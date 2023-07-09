# 🚀 Portainer Update Script 

This repository contains a Bash script to facilitate the process of updating a running Portainer instance. It specifically works with Portainer instances running as standalone Docker containers. The script effectively stops and removes the existing Portainer container, pulls the latest image, and spins up a new container with the same configuration, including port mapping.

## 💡 Features 

- **User Confirmation**: Prompts the user for confirmation before starting the update process.
- **Version Support**: Asks the user whether they're using Portainer CE (Community Edition) or BE (Business Edition).
- **Port Mapping**: Automatically fetches the host port mapped to Portainer's `9000` port in the existing setup, and applies the same mapping for the new container.

## 📝 Usage 

Follow these steps to use this script:

1. Clone this repository:
    ```bash
    git clone https://github.com/Paul1404/Update-Portainer.git
    ```
2. Change your working directory to the cloned repository:
    ```bash
    cd Update-Portainer
    ```
3. Make the script executable:
    ```bash
    chmod +x update_portainer.sh
    ```
4. Run the script:
    ```bash
    ./update_portainer.sh
    ```

## ⚠️ Requirements 

- Docker installed and running on your system.
- An existing Portainer container running on Docker.

## ⚠️ Disclaimer 

Please use this script at your own risk. It is always recommended to backup your data before making changes to your system. This script stops and removes the Portainer container which may result in data loss if the data is not stored on a volume or bind mount.

## 📜 License 

This project is licensed under the [MIT License](https://choosealicense.com/licenses/mit/).

## 🤝 Contact 

Paul Dresch - github@untereuerheim.com

Project Link: https://github.com/Paul1404/Update-Portainer

 
