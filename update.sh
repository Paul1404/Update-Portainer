#!/bin/bash

CONTAINER_NAME="Portainer"

# Check if a command was successful
check_command_success() {
    if [[ $? -ne 0 ]]; then
        echo "Error encountered. Exiting."
        exit 1
    fi
}

# Stop and remove existing container
remove_existing_container() {
    echo "Stopping existing Portainer container..."
    docker stop $CONTAINER_NAME
    check_command_success

    echo "Removing existing Portainer container..."
    docker rm $CONTAINER_NAME
    check_command_success
}

# Pull and run the latest image
update_portainer() {
    local IMAGE_NAME="$1"
    local PORTS="$2"

    echo "Pulling the latest Portainer image..."
    docker pull $IMAGE_NAME
    check_command_success

    echo "Running the new Portainer container..."
    docker run -d -p $PORTS:9000 --name=$CONTAINER_NAME -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data $IMAGE_NAME
    check_command_success
}

# Main script
read -p "This script will stop and remove your existing Portainer container and create a new one with the latest image. Do you want to proceed? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    read -p "Are you using Portainer CE or EE? (ce/ee) " version
    echo

    IMAGE_NAME=""
    if [[ $version == "ce" ]]; then
        IMAGE_NAME="portainer/portainer-ce:latest"
    elif [[ $version == "ee" ]]; then
        IMAGE_NAME="portainer/portainer-ee:latest"
    else
        echo "Invalid version. Please enter either 'ce' or 'ee'."
        exit 1
    fi

    PORTS=$(docker inspect --format='{{(index (index .NetworkSettings.Ports "9000/tcp") 0).HostPort}}' $CONTAINER_NAME)
    if [ -z "$PORTS" ]; then
        echo "Unable to find port mapping for Portainer. Please make sure that Portainer is running and that port 9000 is mapped to a host port."
        exit 1
    fi

    remove_existing_container
    update_portainer $IMAGE_NAME $PORTS

    echo "Status of the new Portainer container:"
    docker ps -a | grep $CONTAINER_NAME

else
    echo "Update canceled."
    exit 1
fi
