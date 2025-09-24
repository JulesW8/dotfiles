#!/bin/bash
# dotfiles -> ~/.config
# Overwrites existing configs with repo versions

CONFIGS=("sway" "wofi")

sync_configs() {
    for dir in "${CONFIGS[@]}"; do
        SRC="$HOME/codespace/dotfiles/.config/$dir"
        DST="$HOME/.config/$dir"
        echo "Syncing $dir..."
        rsync -avh --delete "$SRC/$dir" "$DST/$dir"
    done
    echo "Completed."
}

sync_git() {
    DIR="$HOME/codespace/dotfiles"
    echo "Adding changes to git"
    git -C "$DIR" add .

    TIMESTAMP=$(date +"%d-%m-%Y %H:%M:%S")
    git -C "$DIR" commit -m "Sync configs - $TIMESTAMP" || echo "Nothing to commit!"
    git -C "$DIR" push
    echo "updated repo!"
}

case "$1" in
    -git)
        sync_git
        ;;
    -activate)
        sync_configs
        ;;
    -all)
        sync_git
        sync_configs
        ;;
    *)
        echo "Usage: $0 {-git | -activate | -both}"
        ;;
esac
