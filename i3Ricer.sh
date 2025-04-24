#!/bin/bash
#Author sarojamkatel
#This script will auto rice i3 if everything goes well.

# About Dependencies 

# 1) sxhkd
# sxhkd stands for Simple X HotKey Daemon. It's a lightweight keyboard shortcut daemon for X11.
# It’s primarily used to bind key combinations to specific commands or scripts.
# Simple configuration: You define hotkeys and what they do in a plain-text config file (~/.config/sxhkd/sxhkdrc).
# Custom commands: You can bind keys to any shell command or script you want.

# i3-gaps (for a gap between windows)
# picom (compositor)
# rofi (app launcher)
# polybar (status bar)
# i3lock (screen locker)
# Alacritty (modern terminal, as a termite replacement)
# feh (for setting wallpapers)
# lxappearance (GTK theme switcher)
# dmenu (optional fallback launcher)

# installing Dependencies
sudo apt update && sudo apt upgrade -y
sudo apt install -y \
    i3 i3-gaps \
    picom \
    rofi \
    polybar \
    i3lock \
    alacritty\
    feh \
    lxappearance \
    dmenu \
    git curl

echo "dependencies i3, i3-gaps, picom, rofi, polybar, i3lock, alacritty, feh, lxapperance, dmenu, git curl installed"


echo "Setting up symlink of config files"
TARGET_DIR="$HOME/dotFiles"
configs=("i3" "polybar" "picom" "rofi" "polybar" "i3block" "alacritty" "feh" "lxappearance" "dmenu" ) 

# make .config directory and -p specifies ignore and move on if it already exists 
mkdir -p "$HOME/.config"


#symlinking logic $DEST------> $SRC
for config in "${configs[@]}"; do
    SRC="$TARGET_DIR/.config/$config"
    DEST="$HOME/.config/$config"

    if [ -L "$DEST" ]; then
        echo " $DEST is already a symlink. Skipping."
        continue
    elif [ -e "$DEST" ]; then
        echo "$DEST already exists and is not a symlink."

        read -p " Do you want to back it up and replace it? (y/n): " choice
        if [[ "$choice" == "y" ]]; then
            backup="$DEST.backup"
            i=1
            while [ -e "$backup" ]; do
                backup="$DEST.backup$i"
                ((i++))
            done
            echo " Backing up $DEST to $backup"
            mv "$DEST" "$backup"
        else
            echo " Skipping $DEST"
            continue
        fi
    fi

    echo " Linking $SRC → $DEST"
    ln -s "$SRC" "$DEST"

done

echo " all configs are symlinked successfully. now Reboot or Logout to see changes"
