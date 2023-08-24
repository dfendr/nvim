#!/bin/bash

# Define the image name
IMAGE_NAME="fenvim"
CONTAINER_NAME="fenvim_container"

# Check if the image already exists
docker images | grep -q "$IMAGE_NAME"

# If the image does not exist, build it
if [ $? -ne 0 ]; then
  echo "Image does not exist, building..."
  docker build -t $IMAGE_NAME .
fi

# Check if the container is already running
docker ps | grep -q "$CONTAINER_NAME"

# If the container is running, attach to it
if [ $? -eq 0 ]; then
  echo "Container is running, attaching..."
  docker exec -it $CONTAINER_NAME /bin/bash
else
  # Check if the container exists but is stopped
  docker ps -a | grep -q "$CONTAINER_NAME"
  if [ $? -eq 0 ]; then
    echo "Container exists but is stopped, starting..."
    docker start -i $CONTAINER_NAME
  else
    echo "Container does not exist, creating a new one..."
    docker run --name $CONTAINER_NAME -it $IMAGE_NAME
  fi
fi
