#!/bin/bash
set -e

APP_DIR="/opt/sample-website"
IMAGE_NAME="sample-website"
CONTAINER_NAME="sample-website"

echo "Starting website deployment..."

# Create the application directory
sudo mkdir -p "$APP_DIR"

# Copy the checked-out repository files into the application directory
sudo cp -R . "$APP_DIR/"

cd "$APP_DIR"

# Build the Docker image
sudo docker build -t "$IMAGE_NAME" .

# Stop and remove the previous container, if it exists
sudo docker rm -f "$CONTAINER_NAME" 2>/dev/null || true

# Start the new website container
sudo docker run -d \
  --name "$CONTAINER_NAME" \
  --restart unless-stopped \
  -p 80:80 \
  "$IMAGE_NAME"

echo "Deployment completed successfully."
