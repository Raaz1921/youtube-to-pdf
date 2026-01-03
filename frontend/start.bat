@echo off
REM Quick Start Script for Frontend (Windows)

echo ============================================
echo YouTube to PDF Converter - Frontend Setup
echo ============================================
echo.

REM Check if Node.js is installed
node --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Node.js is not installed.
    echo Please install Node.js from https://nodejs.org/
    pause
    exit /b 1
)

echo [OK] Node.js found
node --version

REM Check if npm is installed
npm --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] npm is not installed.
    pause
    exit /b 1
)

echo [OK] npm found
npm --version

REM Check if node_modules exists
if not exist "node_modules" (
    echo.
    echo Installing dependencies...
    npm install
    echo [OK] Dependencies installed
) else (
    echo [OK] Dependencies already installed
)

REM Check if backend is running
echo.
echo Checking if backend is running on port 8000...
curl -s http://localhost:8000/ >nul 2>&1
if errorlevel 1 (
    echo [WARNING] Backend is not running on port 8000
    echo Please start the backend first:
    echo cd backend2 ^&^& python app.py
    echo.
    set /p continue="Continue anyway? (y/n): "
    if /i not "%continue%"=="y" exit /b 1
) else (
    echo [OK] Backend is running!
)

REM Start the development server
echo.
echo ============================================
echo Starting development server...
echo.
echo Frontend will be available at: http://localhost:3000
echo Make sure backend is running at: http://localhost:8000
echo.
echo Press Ctrl+C to stop the server
echo ============================================
echo.

npm run dev

pause
