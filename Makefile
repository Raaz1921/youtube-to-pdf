.PHONY: help build up down logs restart clean dev prod test

# Default target
help:
	@echo "YouTube to PDF Converter - Available Commands:"
	@echo ""
	@echo "  make build     - Build Docker containers"
	@echo "  make up        - Start services in foreground"
	@echo "  make down      - Stop and remove containers"
	@echo "  make logs      - View logs from all services"
	@echo "  make restart   - Restart all services"
	@echo "  make clean     - Remove containers, volumes, and images"
	@echo "  make dev       - Start development environment with hot-reload"
	@echo "  make prod      - Start production environment"
	@echo "  make test      - Run tests (placeholder)"
	@echo ""

# Build containers
build:
	@echo "Building containers..."
	docker compose build

# Start services (foreground)
up:
	@echo "Starting services..."
	docker compose up

# Start services (background)
start:
	@echo "Starting services in background..."
	docker compose up -d

# Stop services
down:
	@echo "Stopping services..."
	docker compose down

# View logs
logs:
	docker compose logs -f

# Restart services
restart:
	@echo "Restarting services..."
	docker compose restart

# Clean everything
clean:
	@echo "Cleaning up..."
	docker compose down -v --rmi all
	@echo "Cleanup complete!"

# Development mode with hot-reload
dev:
	@echo "Starting development environment..."
	docker compose -f docker-compose.dev.yml up

# Production mode
prod:
	@echo "Starting production environment..."
	docker compose up -d
	@echo "Services started! Visit http://localhost:3000"

# Run tests (placeholder)
test:
	@echo "Running tests..."
	@echo "Tests not yet implemented"

# Quick rebuild
rebuild:
	@echo "Rebuilding containers..."
	docker compose down
	docker compose build --no-cache
	docker compose up
