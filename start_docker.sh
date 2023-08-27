#/bin/bash

IMAGE_NAME="fenvim"
CONTAINER_NAME="fenvim_container"
VOLUME_OPTION=""
MOUNT_PATH=""

show_help() {
	echo "Usage: $0 [options]"
	echo
	echo "Options"
	echo "	-d DIR	Mount a directory into the container at /home/user/workspace"
	echo "	-h, --help	Display this help message and exit"
}

check_running_container() {
	docker ps | grep -q "$CONTAINER_NAME"
}

check_existing_container() {
	docker ps -a | grep -q "$CONTAINER_NAME"
}

check_existing_image() {
	docker ps -a | grep -q "$IMAGE_NAME"
}

attach_to_container() {
	echo "Container is running, attaching..."
	docker exec -t $CONTAINER_NAME /bin/bash
}

start_container() {
	echo "Container exists but is stopped, starting..."
	docker start -i $CONTAINER_NAME
}

build_image() {
	echo "Image does not exist, building..."
	docker build -t $IMAGE_NAME .
}

create_container() {
	echo "Container does not exist, creating a new one..."
	docker run --name $CONTAINER_NAME $VOLUME_OPTION -t $IMAGE_NAME
}

remove_container_and_volume() {
	echo "Removing container and volume..."
	docker rm -v $CONTAINER_NAME
}

while getopts ":hd:r:-:" opt; do
	case $opt in
	d)
		MOUNT_PATH="$OPTARG"
		VOLUME_OPTION="-v $MOUNT_PATH:/home/user/workspace"
		;;
	r)
		remove_container_and_volume
		;;
	h)
		show_help
		exit 0
		;;
	-)
		if [ "$OPTARG" == "help" ]; then
			show_help
			exit 0
		elif [ "$OPTARG" == "remove" ]; then
			remove_container_and_volume
			exit 0
		else
			echo "Invalid option: --$OPTATRG" >&2
			exit 1
		fi
		;;
	\?)
		echo "Invalid option: --$OPTATRG" >&2
		exit 1
		;;
	:)
		echo "Option -$OPTARG requires an argument."
		exit 1
		;;
	esac
done

if check_running_container; then
	attach_to_container
	exit 0
elif check_existing_container; then
	start_container
	exit 0
elif ! check_existing_image; then
	build_image
fi

create_container
