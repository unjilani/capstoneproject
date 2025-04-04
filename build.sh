#!/bin/bash

# Exit on error
set -e

IMAGE=${IMAGE:-"latest"}

# make a function to build the image and take arguements IMAGE_NAME and DOCKERFILE
build_image() {
  IMAGE_NAME=$1
  DOCKERFILE=$2

# printing the action to show the task 
  echo "Building image. IMAGE=$IMAGE_NAME"

# docker building the file and tag 
  docker build . \
    --file "$DOCKERFILE" \
    -t "$IMAGE_NAME"
}

build_image "$IMAGE" Dockerfile