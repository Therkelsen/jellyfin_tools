# Jellyfin Tools
I made these scripts to help ease the updating flow of Jellyfin for myself. I run Jellyfin as a service on Ubuntu 22.04, so just take that into account if you are going to use the scripts.

## Scripts
For now, there are three scripts:

### `create_jellyfin_backup.sh`

Creates a tarball called `jellyfin_backup.tar.gz` which contains your Jellyfin **data** and **config** directories.

### `restore_jellyfin_backup.sh`

Untars the tarball created using `create_jellyfin_backup.sh` and puts the **data** and **config** into the appropriate locations on your machine.

### `update_jellyfin_installation.sh`

Updates Jellyfin using `apt`. Also prompts you to create aliases with which to control Jellyfin:

- `restart_jellyfin`: Restarts the Jellyfin service.

- `start_jellyfin`: Starts the Jellyfin service.

- `stop_jellyfin`: Stops the Jellyfin service.

- `status_jellyfin`: Gives you the Jellyfin service status.