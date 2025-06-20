
#!/bin/bash

# Define variables
backup_dir=~/Documents/jellyfin_backup
data_dir=/var/lib/jellyfin
config_dir=/etc/jellyfin
timestamp=$(date +"%Y%m%d_%H%M%S")
archive_name="jellyfin_backup_$timestamp.tar.gz"

# Check for dry-run flag
dry_run=false
if [[ "$1" == "--dry-run" ]]; then
  dry_run=true
  echo "Running in dry-run mode. Only rsync will be executed."
fi

# Create backup directory
mkdir -p "$backup_dir"

# Define excluded directories
exclude_list=(
  ".aspnet/DataProtection-Keys"
)

# Build rsync exclude options
exclude_args=()
for dir in "${exclude_list[@]}"; do
  exclude_args+=(--exclude="$dir")
done

# Run rsync (with or without dry-run)
echo "Backing up data and config directories..."
rsync_opts=(-a --info=progress2 --relative "${exclude_args[@]}")
if $dry_run; then
  rsync_opts+=(--dry-run)
fi
rsync "${rsync_opts[@]}" "$data_dir" "$config_dir" "$backup_dir"

# Exit early if dry-run
if $dry_run; then
  echo "Dry-run complete. No files were copied or archived."
  exit 0
fi

# Create compressed archive using pigz if available
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
