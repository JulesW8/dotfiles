#!/bin/bash
# dotfiles -> ~/.config
# Overwrites existing configs with repo versions

CONFIGS=("sway" "wofi")

for dir in "${CONFIGS[@]}"; do
    src="$HOME/codespace/dotfiles/.config/$dir/"
    dest="$HOME/.config/$dir/"

    echo "Syncing $dir..."
    rsync -avh --delete "$src" "$dest"
done

echo "Sync complete."
