#!/bin/bash

# Define the image name
IMAGE_NAME="fenvim:latest"

# Check if the image already exists
docker images | grep -q "$IMAGE_NAME"

# If the image does not exist, build it
if [ $? -ne 0 ]; then
  echo "Image does not exist, building..."
  docker build -t $IMAGE_NAME .
fi

# Run the image in interactive mode with a terminal
docker run -it $IMAGE_NAME
