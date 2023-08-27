#/bin/bash

IMAGE_NAME="fenvim"
CONTAINER_NAME="fenvim_container"
VOLUME_OPTION=""
MOUNT_PATH=""

show_help() {
	cat <<-xx
		Usage: $0 [OPTIONS]

		Options:
		 -h,                  Echoes a help command.
		 -n <input>,          Name the container.
		 -t <input>,          Name the image.
		 -u <user>,           Sets the username for the user in the container.
		 -g <name>:<email>,   Sets a global git config name and email for the image.
		 -v <mount_path>,     Expects absolute path. Sets the path for the volume mount.
	xx
	exit 0
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
	docker exec -it $CONTAINER_NAME /bin/bash
}

start_container() {
	echo "Container exists but is stopped, starting..."
	docker start -ai $CONTAINER_NAME
}

build_image() {
	echo "Image does not exist, building..."
	docker build -t $IMAGE_NAME .
}

create_container() {
	echo "Container does not exist, creating a new one..."
	docker run --name $CONTAINER_NAME $VOLUME_OPTION -it $IMAGE_NAME
}

while getopts ":hd:-:" opt; do
	case $opt in
	d)
		MOUNT_PATH="$OPTARG"
		VOLUME_OPTION="-v $MOUNT_PATH:/home/user/workspace"
		;;
	h)
		show_help
		;;
	-)
		if [ "$OPTARG" == "help" ]; then
			show_help
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
