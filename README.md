# Jellyfin Tools

I created these scripts to streamline the updating process of Jellyfin for my personal use. I run Jellyfin as a service on Ubuntu 22.04, so please keep that in mind if you decide to utilize the scripts.

## Scripts

Currently, there are three scripts available:

### `create_jellyfin_backup.sh`

Creates a tarball named `jellyfin_backup.tar.gz`, containing your Jellyfin **data** and **config** directories.

### `update_jellyfin_installation.sh`

Updates Jellyfin using `apt`. It also prompts you to create aliases for controlling Jellyfin:

- `restart_jellyfin`: Restarts the Jellyfin service.
- `start_jellyfin`: Starts the Jellyfin service.
- `stop_jellyfin`: Stops the Jellyfin service.
- `status_jellyfin`: Provides the current status of the Jellyfin service.

### `restore_jellyfin_backup.sh`

Untars the tarball created by `create_jellyfin_backup.sh` and places the **data** and **config** into the appropriate directories on your system.

The presented order of the scripts reflects the recommended sequence of execution, though ideally, you won't need to run `restore_jellyfin_backup.sh`.

## Guide

1. Clone the repository or download the scripts individually.
2. Ensure that the scripts are executable: `sudo chmod +x <script.sh>`.
3. Execute `create_jellyfin_backup.sh` and `update_jellyfin_installation.sh`.
4. In case of emergencies, if something goes wrong, install the previous version of Jellyfin and restore your backup using `restore_jellyfin_backup.sh`.
