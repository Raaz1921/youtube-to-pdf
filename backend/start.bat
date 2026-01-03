@echo off
REM Quick Start Script for YouTube to PDF Converter (Windows)

echo ============================================
echo YouTube to PDF Converter - Quick Start
echo ============================================
echo.

REM Check if Python is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Python is not installed. Please install Python 3.8 or higher.
    pause
    exit /b 1
)

echo [OK] Python found
python --version

REM Check if yt-dlp is installed
yt-dlp --version >nul 2>&1
if errorlevel 1 (
    echo [WARNING] yt-dlp is not installed.
    echo Installing yt-dlp via pip...
    pip install yt-dlp
)

echo [OK] yt-dlp found

REM Create virtual environment if it doesn't exist
if not exist "venv" (
    echo.
    echo Creating virtual environment...
    python -m venv venv
    echo [OK] Virtual environment created
)

REM Activate virtual environment
echo.
echo Activating virtual environment...
call venv\Scripts\activate.bat

REM Install requirements
echo.
echo Installing Python dependencies...
pip install -r requirements.txt

REM Start the server
echo.
echo ============================================
echo Setup complete! Starting server...
echo.
echo Server will be available at: http://localhost:8000
echo API Documentation: http://localhost:8000/docs
echo.
echo Press Ctrl+C to stop the server
echo ============================================
echo.

python app.py

pause
