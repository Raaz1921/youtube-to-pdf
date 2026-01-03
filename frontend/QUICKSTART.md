# 🚀 Quick Start Guide - Full Setup

This guide will help you set up and run both the backend and frontend together.

## 📋 Prerequisites

Before you begin, make sure you have:

- ✅ **Python 3.8+** installed ([Download](https://www.python.org/downloads/))
- ✅ **Node.js 16+** installed ([Download](https://nodejs.org/))
- ✅ **yt-dlp** installed (see below)

## 🎬 Step-by-Step Setup

### Step 1: Install yt-dlp

**macOS:**
```bash
brew install yt-dlp
```

**Windows:**
```bash
pip install yt-dlp
```

**Linux:**
```bash
sudo apt install yt-dlp
# or
pip install yt-dlp
```

### Step 2: Set Up Backend

Open a **new terminal** and run:

```bash
# Navigate to backend folder
cd backend2

# Run the quick start script
# On macOS/Linux:
chmod +x start.sh
./start.sh

# On Windows:
start.bat
```

**The backend will start on `http://localhost:8000`**

### Step 3: Set Up Frontend

Open a **second terminal** (keep the backend running) and run:

```bash
# Navigate to frontend folder
cd frontend2

# Run the quick start script
# On macOS/Linux:
chmod +x start.sh
./start.sh

# On Windows:
start.bat
```

**The frontend will open at `http://localhost:3000`**

## 🎯 Using the App

1. Keep **both terminals open** (backend + frontend)
2. Open your browser to `http://localhost:3000`
3. Paste a YouTube URL
4. Click "Generate PDF"
5. Wait for the download!

## 📝 Example URLs to Test

```
https://www.youtube.com/watch?v=dQw4w9WgXcQ
https://youtu.be/dQw4w9WgXcQ
```

## 🐛 Troubleshooting

### Backend Issues

**"yt-dlp: command not found"**
```bash
# Install yt-dlp
pip install yt-dlp
```

**"Port 8000 already in use"**
```bash
# Find and kill the process using port 8000
# macOS/Linux:
lsof -ti:8000 | xargs kill -9

# Windows:
netstat -ano | findstr :8000
taskkill /PID <PID> /F
```

### Frontend Issues

**"Port 3000 already in use"**
- Edit `frontend2/vite.config.js` and change the port:
```javascript
server: {
  port: 3001, // Change to any available port
}
```

**"Backend server is not responding"**
- Make sure the backend is running on port 8000
- Check if you can access `http://localhost:8000` in your browser

### Common Issues

**"Network error" when generating PDF**
- Check that both backend and frontend are running
- Verify the YouTube URL is valid and accessible
- Check your internet connection

**"Failed to download video"**
- The video might be private or restricted
- Try a different YouTube video
- Update yt-dlp: `pip install --upgrade yt-dlp`

## 🎨 Project Structure

```
Desktop/
├── backend2/          # FastAPI Backend
│   ├── app.py        # Main application
│   ├── start.sh      # Quick start (Unix)
│   └── start.bat     # Quick start (Windows)
│
└── frontend2/         # React Frontend
    ├── src/
    │   ├── App.jsx   # Main component
    │   └── App.css   # Styles
    ├── start.sh      # Quick start (Unix)
    └── start.bat     # Quick start (Windows)
```

## ⚙️ Configuration

### Change Screenshot Interval

Edit `backend2/app.py`:
```python
FRAME_INTERVAL_SECONDS = 5  # Change to 10, 30, 60, etc.
```

### Change Ports

**Backend Port:**
Edit `backend2/app.py`:
```python
uvicorn.run(app, host="0.0.0.0", port=8001, reload=True)
```

**Frontend Port:**
Edit `frontend2/vite.config.js`:
```javascript
server: {
  port: 3001,
}
```

**Update Frontend API URL:**
Edit `frontend2/src/App.jsx`:
```javascript
const API_URL = 'http://localhost:8001'; // Match backend port
```

## 🛑 Stopping the Servers

Press `Ctrl+C` in both terminal windows to stop the servers.

## 📦 Building for Production

### Backend
The backend is already production-ready. Just run:
```bash
cd backend2
python app.py
```

### Frontend
Build the frontend for production:
```bash
cd frontend2
npm run build
```

The production files will be in `frontend2/dist/` folder.

## 🚀 Deployment

### Deploy Backend
- Deploy to any Python hosting service (Heroku, Railway, DigitalOcean)
- Make sure yt-dlp is installed in the environment
- Set environment variables as needed

### Deploy Frontend
- Build the frontend: `npm run build`
- Deploy the `dist/` folder to:
  - Netlify
  - Vercel
  - GitHub Pages
  - Any static hosting service

**Important:** Update the `API_URL` in the frontend to point to your deployed backend!

## 💡 Tips

- **Use short videos** for testing (faster processing)
- **Clear cache** if you see old data
- **Check console** for detailed error messages (F12 in browser)
- **Keep terminals open** while using the app
- **Update yt-dlp** regularly for best compatibility

## 📚 Additional Resources

- Backend Documentation: See `backend2/README.md`
- Frontend Documentation: See `frontend2/README.md`
- API Examples: See `backend2/USAGE.md`

## 🤝 Contributing

Found a bug or want to add a feature? Feel free to:
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## ❤️ Support

If you find this useful, give it a ⭐ on GitHub!

---

**Happy Converting! 🎉**

Need help? Check the individual README files in each folder for more details.
