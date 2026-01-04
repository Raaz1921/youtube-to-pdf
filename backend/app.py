import os
import cv2
import shutil
import tempfile
import numpy as np
from datetime import timedelta

from fastapi import FastAPI, HTTPException, Query, BackgroundTasks
from fastapi.responses import FileResponse, HTMLResponse
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles

from PIL import Image, ImageDraw, ImageFont
from reportlab.pdfgen import canvas
from reportlab.lib.pagesizes import A4, landscape

from yt_dlp import YoutubeDL

# ---------------------------
# App Setup
# ---------------------------

app = FastAPI(
    title="YouTube to PDF Converter",
    version="1.0",
    description="Convert YouTube videos into screenshot-based PDFs"
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

# Mount static files
app.mount("/static", StaticFiles(directory="static"), name="static")

# ---------------------------
# Helpers
# ---------------------------

def download_youtube_video(url: str, output_path: str, quality: int):
    ydl_opts = {
        "format": f"best[height<={quality}]",
        "merge_output_format": "mp4",
        "outtmpl": output_path,
        "quiet": True,
        "no_warnings": True,
        "noplaylist": True,
        "retries": 3,
        "nocheckcertificate": True,
    }

    with YoutubeDL(ydl_opts) as ydl:
        ydl.download([url])

    if not os.path.exists(output_path):
        raise RuntimeError("Video file not created")


def add_timestamp(frame, seconds):
    frame_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
    img = Image.fromarray(frame_rgb)
    draw = ImageDraw.Draw(img)

    timestamp = str(timedelta(seconds=seconds))

    try:
        # Try common font paths for Linux (Render) and macOS
        font_paths = [
            "/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf",  # Linux
            "/System/Library/Fonts/Helvetica.ttc",  # macOS
        ]
        font = None
        for path in font_paths:
            if os.path.exists(path):
                font = ImageFont.truetype(path, 36)
                break
        if font is None:
            font = ImageFont.load_default()
    except:
        font = ImageFont.load_default()

    w, h = draw.textbbox((0, 0), timestamp, font=font)[2:]
    x = img.width - w - 20
    y = img.height - h - 20

    draw.rectangle([x - 10, y - 10, x + w + 10, y + h + 10], fill="black")
    draw.text((x, y), timestamp, fill="white", font=font)

    return cv2.cvtColor(np.array(img), cv2.COLOR_RGB2BGR)


def extract_frames(video_path, frames_dir, interval_sec):
    cap = cv2.VideoCapture(video_path)
    if not cap.isOpened():
        raise RuntimeError("Cannot open video")

    fps = cap.get(cv2.CAP_PROP_FPS)
    frame_interval = int(fps * interval_sec)

    count = 0
    saved = 0

    while True:
        ret, frame = cap.read()
        if not ret:
            break

        if count % frame_interval == 0:
            sec = int(count / fps)
            frame = add_timestamp(frame, sec)
            cv2.imwrite(os.path.join(frames_dir, f"frame_{saved:05d}.jpg"), frame)
            saved += 1

        count += 1

    cap.release()

    if saved == 0:
        raise RuntimeError("No frames extracted")


def create_pdf(frames_dir, pdf_path):
    page_w, page_h = landscape(A4)
    c = canvas.Canvas(pdf_path, pagesize=(page_w, page_h))

    images = sorted(f for f in os.listdir(frames_dir) if f.endswith(".jpg"))
    if not images:
        raise RuntimeError("No images to create PDF")

    for img in images:
        img_path = os.path.join(frames_dir, img)
        iw, ih = Image.open(img_path).size

        ratio = min(page_w / iw, page_h / ih)
        w, h = iw * ratio, ih * ratio
        x, y = (page_w - w) / 2, (page_h - h) / 2

        c.drawImage(img_path, x, y, w, h)
        c.showPage()

    c.save()

# ---------------------------
# Routes
# ---------------------------

@app.get("/", response_class=HTMLResponse)
def root():
    with open("static/index.html", "r") as f:
        return f.read()

@app.get("/generate")
def generate_pdf(
    background_tasks: BackgroundTasks,
    url: str = Query(...),
    quality: int = Query(720, ge=360, le=1080),
    interval: int = Query(60, ge=1, le=90),
):
    temp_dir = tempfile.mkdtemp()
    video_path = os.path.join(temp_dir, "video.mp4")
    frames_dir = os.path.join(temp_dir, "frames")
    pdf_path = os.path.join(temp_dir, "output.pdf")

    os.makedirs(frames_dir, exist_ok=True)

    try:
        download_youtube_video(url, video_path, quality)
        extract_frames(video_path, frames_dir, interval)
        create_pdf(frames_dir, pdf_path)

        if not os.path.exists(pdf_path):
            raise RuntimeError("PDF not created")

        background_tasks.add_task(shutil.rmtree, temp_dir)

        return FileResponse(
            pdf_path,
            media_type="application/pdf",
            filename="youtube_screenshots.pdf",
        )

    except Exception as e:
        background_tasks.add_task(shutil.rmtree, temp_dir)
        raise HTTPException(status_code=500, detail=str(e))