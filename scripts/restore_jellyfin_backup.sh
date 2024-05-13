#!/bin/bash

# Prompt user to confirm Jellyfin has been stopped
read -p "Please confirm that Jellyfin has been stopped, so the backup restoration process can continue. (y/n): " confirm
if [[ $confirm != [Yy] ]]; then
    echo "Aborted."
    exit 0
fi

# Define variables
backup_path=~/Documents/
data_backup=~/Documents/jellyfin_backup/var/lib/jellyfin/
config_backup=~/Documents/jellyfin_backup/etc/jellyfin/
data_dir=/var/lib/
config_dir=/etc/

# Untar backup
cd "$backup_path" || exit
echo "Untarring backup tarball."
if ! pv jellyfin_backup.tar.gz | tar -xz; then
    echo "Error: Failed to untar backup."
    exit 1
fi

# Move backup files to Jellyfin directory
echo -e "\nRestoring backup to Jellyfin directory"

# Restore data directory
echo -e "\nCopying data directory."
echo -e "\nData directory size:"
du -h -d 0 "$data_backup"
if ! sudo rsync -a --info=progress2 --relative "$data_backup" "$data_dir"; then
    echo "Error: Failed to restore data directory."
    exit 1
fi

# Restore config directory
echo -e "\nCopying config directory."
echo -e "\nConfig directory size:"
du -h -d 0 "$config_backup"
if ! sudo rsync -a --info=progress2 --relative "$config_backup" "$config_dir"; then
    echo "Error: Failed to restore config directory."
    exit 1
fi

# Change ownership of files
echo -e "\nChanging ownership of Jellyfin files."
sudo chown -R jellyfin: /etc/jellyfin /var/lib/jellyfin

rm -r jellyfin_backup
echo -e "\nBackup restoration complete. You can safely start Jellyfin."