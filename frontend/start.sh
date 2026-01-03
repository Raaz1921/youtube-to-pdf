#!/bin/bash

# Quick Start Script for Frontend
# This script helps you set up and run the frontend quickly

echo "🎨 YouTube to PDF Converter - Frontend Setup"
echo "=============================================="
echo ""

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed."
    echo "   Please install Node.js from https://nodejs.org/"
    exit 1
fi

echo "✅ Node.js found: $(node --version)"

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo "❌ npm is not installed."
    exit 1
fi

echo "✅ npm found: $(npm --version)"

# Check if node_modules exists
if [ ! -d "node_modules" ]; then
    echo ""
    echo "📦 Installing dependencies..."
    npm install
    echo "✅ Dependencies installed"
else
    echo "✅ Dependencies already installed"
fi

# Check if backend is running
echo ""
echo "🔍 Checking if backend is running on port 8000..."
if curl -s http://localhost:8000/ > /dev/null 2>&1; then
    echo "✅ Backend is running!"
else
    echo "⚠️  Backend is not running on port 8000"
    echo "   Please start the backend first:"
    echo "   cd backend2 && python app.py"
    echo ""
    read -p "   Continue anyway? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Start the development server
echo ""
echo "🎉 Starting development server..."
echo ""
echo "📍 Frontend will be available at: http://localhost:3000"
echo "📍 Make sure backend is running at: http://localhost:8000"
echo ""
echo "🛑 Press Ctrl+C to stop the server"
echo ""

npm run dev
