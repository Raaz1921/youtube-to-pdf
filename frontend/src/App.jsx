import { useState } from "react";
import {
  Youtube,
  FileText,
  Download,
  Loader2,
  CheckCircle2,
  XCircle,
  Clock,
  Sparkles,
  AlertCircle,
} from "lucide-react";
import "./App.css";

// Use /api in production (proxied by nginx), localhost:8000 in development
const API_URL = import.meta.env.PROD ? "/api" : "http://localhost:8000";

function App() {
  const [url, setUrl] = useState("");
  const [quality, setQuality] = useState("720");
  const [interval, setInterval] = useState(60);
  const [loading, setLoading] = useState(false);
  const [status, setStatus] = useState("");
  const [error, setError] = useState("");
  const [success, setSuccess] = useState(false);

  const steps = [
    "Connecting to server…",
    "Downloading video…",
    "Extracting PDF…",
    "Creating PDF…",
    "Finalizing download…",
  ];

  const validateYoutubeUrl = (url) => {
    const patterns = [
      /^(https?:\/\/)?(www\.)?(youtube\.com\/watch\?v=|youtu\.be\/)[\w-]+/,
    ];
    return patterns.some((p) => p.test(url));
  };

  const runFakeProgress = () => {
    let i = 0;
    setStatus(steps[i]);

    const timer = setInterval(() => {
      i++;
      if (i < steps.length) {
        setStatus(steps[i]);
      } else {
        clearInterval(timer);
      }
    }, 3000);

    return () => clearInterval(timer);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError("");
    setSuccess(false);

    if (!url.trim()) {
      setError("Please enter a YouTube URL");
      return;
    }

    if (!validateYoutubeUrl(url)) {
      setError("Invalid YouTube URL");
      return;
    }

    if (interval < 1 || interval > 90) {
      setError("Interval must be between 1 and 90 seconds");
      return;
    }

    setLoading(true);
    const stopFakeProgress = runFakeProgress();

    try {
      const response = await fetch(
        `${API_URL}/generate?url=${encodeURIComponent(
          url
        )}&quality=${quality}&interval=${interval}`
      );

      if (!response.ok) {
        const data = await response.json();
        throw new Error(data.detail || "Failed to generate PDF");
      }

      const blob = await response.blob();
      const downloadUrl = window.URL.createObjectURL(blob);

      const a = document.createElement("a");
      a.href = downloadUrl;
      a.download = "youtube_screenshots.pdf";
      document.body.appendChild(a);
      a.click();
      document.body.removeChild(a);
      window.URL.revokeObjectURL(downloadUrl);

      setSuccess(true);
      setStatus("PDF downloaded successfully");
      setUrl("");

      setTimeout(() => {
        setSuccess(false);
        setStatus("");
      }, 4000);
    } catch (err) {
      setError(err.message || "Something went wrong");
    } finally {
      stopFakeProgress();
      setLoading(false);
    }
  };

  return (
    <div className="app fade-in">
      <header className="header">
        <div className="header-content">
          <div className="logo">
            <Youtube />
            <FileText />
          </div>
          <h1>YouTube to PDF Converter</h1>
          <p>Convert videos into timestamped screenshot PDFs</p>
        </div>
      </header>

      <main className="main">
        <div className="card converter-card">
          <form onSubmit={handleSubmit} className="form">
            <input
              className="input"
              placeholder="Paste YouTube URL"
              value={url}
              onChange={(e) => setUrl(e.target.value)}
              disabled={loading}
            />

            <select
              className="input"
              value={quality}
              onChange={(e) => setQuality(e.target.value)}
              disabled={loading}
            >
              <option value="360">360p</option>
              <option value="480">480p</option>
              <option value="720">720p</option>
              <option value="1080">1080p</option>
            </select>

            <input
              type="number"
              className="input"
              min="1"
              max="90"
              value={interval}
              onChange={(e) => setInterval(Number(e.target.value))}
              placeholder="Interval (seconds)"
              disabled={loading}
            />

            <button className="btn btn-primary" disabled={loading}>
              {loading ? (
                <>
                  <Loader2 className="spinning" /> Processing…
                </>
              ) : (
                <>
                  <Download /> Generate PDF
                </>
              )}
            </button>
          </form>

          {loading && status && (
            <div className="status-message loading">
              <Loader2 className="spinning" /> {status}
            </div>
          )}

          {success && (
            <div className="status-message success">
              <CheckCircle2 /> {status}
            </div>
          )}

          {error && (
            <div className="status-message error">
              <XCircle /> {error}
            </div>
          )}
        </div>

        <div className="features-grid">
          <div className="feature-card">
            <Clock /> Custom interval
          </div>
          <div className="feature-card">
            <Sparkles /> Quality control
          </div>
          <div className="feature-card">
            <Download /> One-click PDF
          </div>
        </div>

        <div className="card instructions-card">
          <h2>
            <AlertCircle /> How it works
          </h2>
          <ol>
            <li>Paste YouTube link</li>
            <li>Select quality & interval</li>
            <li>Generate and download PDF</li>
          </ol>
        </div>
      </main>

      <footer className="footer">
        Powered by FastAPI & React
      </footer>
    </div>
  );
}

export default App;