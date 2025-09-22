#!/bin/bash
# dotfiles -> ~/.config
# Overwrites existing configs with repo versions

CONFIGS = ("backgrounds" "fastfetch" "sway" "waybar" "wofi")

for c in "${CONFIGS[@]}"; do
    src="$HOME/dotfiles/.config/$c"
    dest="$HOME/.config/$c"

    if [ -d "$src" ]; then
        echo "Syncing $c..."
        rm -rf "$dest"
        cp -r "$src" "$dest"
    fi
done

echo "Sync complete."