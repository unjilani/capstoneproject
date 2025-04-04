#!/bin/bash

# Exit on error
set -e  

# Configuration Variables
IMAGE_NAME=${IMAGE_NAME:-"MyApp"}  # Default Docker image name
TAG=${TAG:-"latest"}                # Default tag
DOCKERFILE="dockerfile"             # Dockerfile name
PORT=8080                            # Change to required port

# Build Docker Image
echo "Building Docker image: $IMAGE_NAME:$TAG"
docker build -t "$IMAGE_NAME:$TAG" -f "$DOCKERFILE" .

echo " deploy Running new container..."
  docker run -d --name "$IMAGE_NAME" -p $PORT:$PORT "$IMAGE_NAME:$TAG"

echo "Deployment complete!"

echo "Deployment finished successfully!"
