#!/bin/bash

# Quick Start Script for YouTube to PDF Converter
# This script helps you set up and run the backend quickly

echo "🚀 YouTube to PDF Converter - Quick Start"
echo "=========================================="
echo ""

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 is not installed. Please install Python 3.8 or higher."
    exit 1
fi

echo "✅ Python 3 found: $(python3 --version)"

# Check if yt-dlp is installed
if ! command -v yt-dlp &> /dev/null; then
    echo "⚠️  yt-dlp is not installed."
    echo "   Install it using: brew install yt-dlp (macOS) or pip install yt-dlp"
    read -p "   Would you like to install it via pip now? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        pip3 install yt-dlp
    else
        echo "❌ yt-dlp is required. Please install it and run this script again."
        exit 1
    fi
fi

echo "✅ yt-dlp found: $(yt-dlp --version)"

# Create virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo ""
    echo "📦 Creating virtual environment..."
    python3 -m venv venv
    echo "✅ Virtual environment created"
fi

# Activate virtual environment
echo ""
echo "🔧 Activating virtual environment..."
source venv/bin/activate

# Install requirements
echo ""
echo "📥 Installing Python dependencies..."
pip install -r requirements.txt

# Start the server
echo ""
echo "🎉 Setup complete! Starting server..."
echo ""
echo "📍 Server will be available at: http://localhost:8000"
echo "📍 API Documentation: http://localhost:8000/docs"
echo ""
echo "🛑 Press Ctrl+C to stop the server"
echo ""

python app.py
