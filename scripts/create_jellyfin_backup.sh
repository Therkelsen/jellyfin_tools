#!/bin/bash

# Define variables
backup_dir=~/Documents/jellyfin_backup
data_dir=/var/lib/jellyfin
config_dir=/etc/jellyfin

# Ensure backup directory exists
echo "Creating temporary backup directory."
mkdir -p "$backup_dir"
cd "$backup_dir" || exit

# Backup data directory
echo -e "\nCopying data directory."
echo -e "\nData directory size:"
du -h -d 0 "$data_dir"
rsync -a --info=progress2 --relative "$data_dir" .

# Backup config directory
echo -e "\nCopying config directory."
echo -e "\nConfig directory size:"
du -h -d 0 "$config_dir"
rsync -a --info=progress2 --relative "$config_dir" .

# Create tarball
echo -e "\nCreating tarball."
cd ..
tar cf - "$(basename "$backup_dir")" -P --warning=no-file-changed | pv -s "$(du -sb "$backup_dir" | awk '{print $1}')" | gzip > jellyfin_backup.tar.gz

# Remove temporary directory
echo -e "\nRemoving temporary directory."
rm -r "$backup_dir"

echo -e "\nBackup complete."