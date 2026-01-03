# YouTube to PDF Converter - Frontend

A beautiful, modern React frontend for the YouTube to PDF converter. Convert any YouTube video into a PDF with timestamped screenshots.

## ✨ Features

- 🎨 **Modern UI**: Clean, responsive design with smooth animations
- 🌙 **Dark Theme**: Easy on the eyes with a professional dark theme
- ⚡ **Real-time Feedback**: Live status updates during processing
- 🔄 **URL Validation**: Automatic YouTube URL validation
- 📱 **Responsive**: Works perfectly on desktop, tablet, and mobile
- ✅ **Error Handling**: Clear error messages and status indicators
- 🎯 **User-Friendly**: Simple, intuitive interface

## 📋 Prerequisites

- Node.js 16.x or higher
- npm or yarn
- Backend server running on `localhost:8000`

## 🚀 Installation

### 1. Install Dependencies

```bash
cd frontend2
npm install
# or
yarn install
```

### 2. Start Development Server

```bash
npm run dev
# or
yarn dev
```

The app will open at `http://localhost:3000`

## 🎮 Usage

1. **Make sure the backend is running** on `localhost:8000`
2. Open the frontend at `http://localhost:3000`
3. Paste a YouTube URL in the input field
4. Click "Generate PDF"
5. Wait for processing (you'll see status updates)
6. PDF will download automatically when ready!

## 📁 Project Structure

```
frontend2/
├── src/
│   ├── App.jsx         # Main application component
│   ├── App.css         # Application styles
│   ├── main.jsx        # React entry point
│   └── index.css       # Global styles
├── index.html          # HTML template
├── package.json        # Dependencies and scripts
├── vite.config.js      # Vite configuration
└── README.md          # This file
```

## ⚙️ Configuration

### Backend URL

The frontend expects the backend to run on `http://localhost:8000`. To change this, edit the `API_URL` constant in `src/App.jsx`:

```javascript
const API_URL = 'http://localhost:8000'; // Change this if needed
```

## 🔧 Available Scripts

### Development

```bash
npm run dev
```
Starts the development server with hot reload at `http://localhost:3000`

### Build

```bash
npm run build
```
Creates an optimized production build in the `dist/` folder

### Preview

```bash
npm run preview
```
Preview the production build locally

## 🎨 Customization

### Colors

Edit CSS variables in `src/index.css`:

```css
:root {
  --primary: #2563eb;        /* Primary blue */
  --success: #10b981;        /* Success green */
  --error: #ef4444;          /* Error red */
  --bg-main: #0f172a;        /* Main background */
  --bg-card: #1e293b;        /* Card background */
  /* ... more variables */
}
```

### Screenshot Interval

The screenshot interval is set on the backend (5 seconds by default). To change it, modify `FRAME_INTERVAL_SECONDS` in `backend2/app.py`.

## 📦 Building for Production

```bash
# Build the app
npm run build

# The output will be in the 'dist' folder
# You can deploy this folder to any static hosting service
```

### Deployment Options

- **Netlify**: Drag and drop the `dist` folder
- **Vercel**: Run `vercel --prod`
- **GitHub Pages**: Push `dist` folder to `gh-pages` branch
- **Any static host**: Upload the `dist` folder

## 🔍 Troubleshooting

### "Backend server is not responding"

**Solution**: Make sure the backend is running on port 8000
```bash
cd backend2
python app.py
```

### Port 3000 already in use

**Solution**: Change the port in `vite.config.js`:
```javascript
server: {
  port: 3001, // or any other port
}
```

### CORS errors

**Solution**: The backend already has CORS enabled. If you still see errors, check that:
- Backend is running
- You're accessing frontend from `localhost:3000`
- Backend CORS settings allow your origin

## 🌟 Features Breakdown

### URL Validation
- Automatically validates YouTube URLs
- Supports both `youtube.com/watch?v=` and `youtu.be/` formats
- Shows error for invalid URLs

### Status Updates
- "Connecting to server..."
- "Downloading video..."
- "Extracting screenshots with timestamps..."
- "PDF downloaded successfully!"

### Error Handling
- Network errors
- Invalid URLs
- Backend errors
- User-friendly error messages

## 🤝 Contributing

Feel free to fork and submit pull requests!

## 📝 License

MIT License - Feel free to use this project for personal or commercial purposes.

## 🎯 Tips

- Use shorter videos for faster processing
- Make sure videos are publicly accessible
- Check that the backend server is running before starting
- The PDF filename is always `youtube_screenshots.pdf`

---

**Made with ❤️ using React + Vite**
