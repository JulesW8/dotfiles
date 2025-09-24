#!/bin/bash
# dotfiles -> ~/.config
# Overwrites existing configs with repo versions

CONFIGS=("sway" "wofi")

DIR="$HOME/codespace/dotfiles"
SRC="$HOME/codespace/dotfiles/.config/"
DST="$HOME/.config/"

sync_configs() {
    for dir in "${CONFIGS[@]}"; do
        echo "Syncing $d..."
        rsync -avh --delete "$SRC/$d" "$DST/$d"
    done
    echo "Rollout configs from $SRC to $DST completed."
}

sync_git() {
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
