#!/bin/bash

# Define variables
backup_dir=~/Documents/jellyfin_backup
data_dir=/var/lib/jellyfin
config_dir=/etc/jellyfin
timestamp=$(date +"%Y%m%d_%H%M%S")
archive_name="jellyfin_backup_$timestamp.tar.gz"

# Create backup directory
mkdir -p "$backup_dir"

# Use rsync with compression and parallelism
echo "Backing up data and config directories..."
rsync -a --info=progress2 --relative "$data_dir" "$config_dir" "$backup_dir"

# Create tarball with pigz (parallel gzip) if available
echo "Creating compressed archive..."
cd ~/Documents || exit
if command -v pigz &> /dev/null; then
  tar cf - "$(basename "$backup_dir")" -P --warning=no-file-changed | pigz > "$archive_name"
else
  tar cf - "$(basename "$backup_dir")" -P --warning=no-file-changed | gzip > "$archive_name"
fi

# Clean up
rm -rf "$backup_dir"
echo "Backup complete: $archive_name"
