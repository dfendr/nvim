#!/bin/bash

# Define the image name
IMAGE_NAME="fenvim"
CONTAINER_NAME="fenvim_container"

# Check if the container is already running
docker ps | grep -q "$CONTAINER_NAME"

# If the container is running, attach to it
if [ $? -eq 0 ]; then
	echo "Container is running, attaching..."
	docker exec -it $CONTAINER_NAME /bin/bash
	exit 0
fi

# Check if the container exists but is stopped
docker ps -a | grep -q "$CONTAINER_NAME"
if [ $? -eq 0 ]; then
	echo "Container exists but is stopped, starting..."
	docker start -i $CONTAINER_NAME
	exit 0
fi

# Check if the image already exists
docker images | grep -q "$IMAGE_NAME"

# If the image does not exist, build it
if [ $? -ne 0 ]; then
	echo "Image does not exist, building..."
	docker build -t $IMAGE_NAME .
fi

# Ask if the user wants to mount a volume
read -p "Do you want to mount a volume to the filesystem? (y/n): " MOUNT_VOLUME

if [ "$MOUNT_VOLUME" = "y" ]; then
	echo "Choose the directory to mount:"
	echo "1: Current directory"
	echo "2: Home directory"
	echo "3: Custom directory"
	read -p "Enter your choice (1/2/3): " DIRECTORY_CHOICE
	case "$DIRECTORY_CHOICE" in
		1)
			MOUNT_PATH="$(pwd)" # Mounting current directory
			;;
		2)
			MOUNT_PATH="$HOME" # Mounting home directory
			;;
		3)
			read -p "Please enter the custom directory path: " MOUNT_PATH
			;;
		*)
			echo "Invalid choice, using current directory as default."
			MOUNT_PATH="$(pwd)" # Default to current directory
			;;
	esac
	VOLUME_OPTION="-v $MOUNT_PATH:/home/user/workspace"
else
	VOLUME_OPTION=""
fi

# Debugging lines
echo "Mount Path: $MOUNT_PATH"
echo "Volume Option: $VOLUME_OPTION"

# Since the container does not exist, create a new one
echo "Container does not exist, creating a new one..."
docker run --name $CONTAINER_NAME $VOLUME_OPTION -it $IMAGE_NAME
