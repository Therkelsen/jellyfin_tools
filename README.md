# Jellyfin Tools
I made these scripts to help ease the updating flow of Jellyfin for myself. I run Jellyfin as a service on Ubuntu 22.04, so just take that into account if you are going to use the scripts.

## Scripts
For now, there are three scripts:

### `create_jellyfin_backup.sh`

Creates a tarball called `jellyfin_backup.tar.gz` which contains your Jellyfin **data** and **config** directories.

### `update_jellyfin_installation.sh`

Updates Jellyfin using `apt`. Also prompts you to create aliases with which to control Jellyfin:

### `restore_jellyfin_backup.sh`

Untars the tarball created using `create_jellyfin_backup.sh` and puts the **data** and **config** into the appropriate locations on your machine.

The order in which the scripts have been presented is also the order in which they should be run. Although hopefully you won't have to run `restore_jellyfin_backup.sh`.

- `restart_jellyfin`: Restarts the Jellyfin service.

- `start_jellyfin`: Starts the Jellyfin service.

- `stop_jellyfin`: Stops the Jellyfin service.

- `status_jellyfin`: Gives you the Jellyfin service status.

## Guide

1. Clone repo or download scripts individually

2. Make sure that the scripts are executable: `sudo chmod +x <script.sh>`

3. Run `create_jellyfin_backup.sh` and `update_jellyfin_installation.sh`.

4. Emergency - If something breaks, install the old version of Jellyfin and restore your backup using `restore_jellyfin_backup.sh`.