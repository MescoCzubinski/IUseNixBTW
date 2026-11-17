#!/usr/bin/env bash

# files-backup  mirror Notes, Projects, Pictures, Saved and the NixOS config to the Backup disk

set -e

dest=/run/media/mieszko/Backup/Auto

rsync -avh ~/Notes/ "$dest/Notes/"
rsync -avh --exclude='.venv' --exclude='node_modules' ~/Projects/ "$dest/Projects/"
rsync -avh --delete ~/Pictures/ "$dest/Pictures/"
rsync -avh --delete ~/Saved/ "$dest/Saved/"
rsync -avh --delete ~/.nixos/ "$dest/NixOS/"
