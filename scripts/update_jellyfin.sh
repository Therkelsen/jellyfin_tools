#!/bin/bash

# Update Jellyfin
echo "Updating Jellyfin through repository using curl."
sudo apt update && sudo apt upgrade jellyfin -y

# Prompt user to install aliases
read -p "Do you want to install aliases to manage the Jellyfin service? (y/n): " install_aliases
if [[ $install_aliases == [Yy] ]]; then
    # Define aliases
    jellyfin_aliases='
alias restart_jellyfin="echo \"Restarting Jellyfin service\" && sudo systemctl restart jellyfin"
alias start_jellyfin="echo \"Starting Jellyfin service\" && sudo systemctl start jellyfin"
alias stop_jellyfin="echo \"Stopping Jellyfin service\" && sudo systemctl stop jellyfin"
alias status_jellyfin="echo \"Jellyfin service status\" && sudo systemctl status jellyfin"
'

    # Add aliases to bashrc
    echo -e "$jellyfin_aliases" >> ~/.bashrc

    # Source bashrc
    source ~/.bashrc
    echo "Aliases installed. You can now manage the Jellyfin service using the following commands:"
    echo "restart_jellyfin, start_jellyfin, stop_jellyfin, status_jellyfin"
fi