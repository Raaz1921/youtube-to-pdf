# YouTube to PDF Converter

Convert YouTube videos into PDFs with ease. This application downloads videos, extracts frames at specified intervals, adds timestamps, and compiles them into a downloadable PDF.
1. Paste a YouTube video URL
2. Select video quality (360p, 480p, 720p, or 1080p)
3. Set frame extraction interval (1-120 seconds)
4. Click "Generate PDF"
5. Wait for processing (download starts automatically)


## 🚀 Features

- 📹 Download pdf from YouTube
- ⏱️ Extract frames at custom intervals (1-120 seconds)
- 🎨 Automatic timestamp overlay
- 📄 Generate PDF 
- 🎯 Quality control (360p - 1080p)
- 🐳 Fully Dockerized setup
- ⚡ Fast and efficient processing


## 🏗️ Project Structure

```
youtube-to-pdf/
├── backend/
│   ├── app.py              # FastAPI application
│   ├── requirements.txt    # Python dependencies
│   ├── Dockerfile          # Backend container config
│   └── .dockerignore       # Docker ignore rules
│
├── frontend/
│   ├── src/
│   │   ├── App.jsx         # Main React component
│   │   └── ...
│   ├── package.json        # Node dependencies
│   ├── vite.config.js      # Vite configuration
│   ├── nginx.conf          # Nginx configuration
│   ├── Dockerfile          # Frontend container config
│   └── .dockerignore       # Docker ignore rules
│
├── docker-compose.yml      # Orchestration config
└── README.md               # This file
```

## 🔧 Development

### Local Development (Without Docker)

**Backend:**

```
## Backend (macOS / Linux)
bash
cd ~/Desktop
git clone https://github.com/Raaz1921/youtube-to-pdf.git
cd youtube-to-pdf
cd backend
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
uvicorn app:app --host 127.0.0.1 --port 8000
<!-- (uvicorn app:app --reload --port 8000 ) -->

   
#### Windows
```md
## Backend (Windows)

```powershell
cd Desktop
git clone https://github.com/Raaz1921/youtube-to-pdf.git
cd youtube-to-pdf
cd backend
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
uvicorn app:app --host 127.0.0.1 --port 8000
<!-- (uvicorn app:app --reload --port 8000 ) -->

```

**Frontend:**
```
bash
cd ~/Desktop
cd youtube-to-pdf
cd frontend
npm install
npm run dev

```
### Docker Commands

## 📋 Prerequisites

- [Docker](https://docs.docker.com/get-docker/) (20.10 or higher)
- [Docker Compose](https://docs.docker.com/compose/install/) (2.0 or higher)
- Git

### 1. Clone the Repository
```
cd desktop (Recommended)
git clone https://github.com/yourusername/youtube-to-pdf.git
cd youtube-to-pdf
docker compose up
Open http://localhost:3000 in your browser
```


**Parameters:**
- `url` (required): YouTube video URL
- `quality` (optional): Video quality - 360, 480, 720, or 1080 (default: 720)
- `interval` (optional): Frame extraction interval in seconds, 1-120 (default: 60)



### Video Download Fails
- Check your internet connection
- Verify the YouTube URL is valid
- Some videos may be region-restricted or age-restricted



## 🔒 Security Notes

- This application is for personal/educational use
- Respect YouTube's Terms of Service
- Don't use for copyright infringement
- Rate limiting may apply for video downloads


## 📝 License

This project is open source and available under the [MIT License](LICENSE).

## 🙏 Acknowledgments

- [FastAPI](https://fastapi.tiangolo.com/) - Modern Python web framework
- [yt-dlp](https://github.com/yt-dlp/yt-dlp) - YouTube video downloader
- [React](https://react.dev/) - Frontend framework
- [Vite](https://vitejs.dev/) - Build tool
- [ReportLab](https://www.reportlab.com/) - PDF generation

## 📧 Support

If you encounter any issues or have questions:
1. Check the [Troubleshooting](#-troubleshooting) section
2. Search [existing issues](https://github.com/Raaz1921/youtube-to-pdf/issues)
3. Create a [new issue](https://github.com/Raaz1921/youtube-to-pdf/issues/new)

---

Made by [Raaz]
