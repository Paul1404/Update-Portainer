#!/bin/bash

# Name of the existing Portainer container
CONTAINER_NAME="Portainer"

# Ask user for confirmation
read -p "This script will stop and remove your existing Portainer container and create a new one with the latest image. Do you want to proceed? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # Ask user for the version of Portainer
    read -p "Are you using Portainer CE or BE? (ce/be) " version
    echo

    if [[ $version == "ce" ]]
    then
        IMAGE_NAME="portainer/portainer-ce:latest"
    elif [[ $version == "be" ]]
    then
        IMAGE_NAME="portainer/portainer:latest"
    else
        echo "Invalid version. Please enter either 'ce' or 'be'."
        exit 1
    fi

    # Get existing Portainer ports
    PORTS=$(docker inspect --format='{{(index (index .NetworkSettings.Ports "9000/tcp") 0).HostPort}}' $CONTAINER_NAME)

    # Stop the existing Portainer container
    docker stop $CONTAINER_NAME

    # Remove the existing Portainer container
    docker rm $CONTAINER_NAME

    # Pull the latest image of Portainer
    docker pull $IMAGE_NAME

    # Run a new Portainer container with the latest image
    docker run -d -p $PORTS:9000 --name=$CONTAINER_NAME -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data $IMAGE_NAME

    # Print the status of the new Portainer container
    docker ps -a | grep $CONTAINER_NAME
else
    echo "Update canceled."
    exit 1
fi
