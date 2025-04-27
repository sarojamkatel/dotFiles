#!/bin/bash
#Author sarojamkatel
#This script will auto rice i3 if everything goes well.

# About Dependencies 

# 1) sxhkd
# sxhkd stands for Simple X HotKey Daemon. It's a lightweight keyboard shortcut daemon for X11.
# It’s primarily used to bind key combinations to specific commands or scripts.
# Simple configuration: You define hotkeys and what they do in a plain-text config file (~/.config/sxhkd/sxhkdrc).
# Custom commands: You can bind keys to any shell command or script you want.

# i3 a tiling window manager .
# picom (compositor)
# rofi (app launcher)
# polybar (status bar)
# i3lock (screen locker)
# Alacritty (modern terminal, as a termite replacement)
# feh (for setting wallpapers)
# lxappearance (GTK theme switcher): 
#Note# A GTK application is a program built using the GNOME Toolkit (GTK).
#LXAppearance is a tool used for configuring the appearance of GTK applications. It allows users to change themes, icon themes, fonts, and other visual settings for GTK-based applications. 

# dmenu (optional fallback launcher)

# installing Dependencies
# sudo apt update && sudo apt upgrade -y
# sudo apt install -y \
#     i3  \
#     picom \
#     rofi \
#     polybar \
#     i3lock \
#     alacritty\
#     feh \
#     lxappearance \
#     dmenu \
#     git curl

# echo "dependencies i3, i3-gaps, picom, rofi, polybar, i3lock, alacritty, feh, lxapperance, dmenu, git curl installed"

#..........................................................................................

# installing dependencies in a more verbose mode
# Function to install a package with verbose info
# install_package() {
#     local pkg="$1"
#     echo -e "\n Installing: $pkg ..."
    
#     if apt-cache show "$pkg" &>/dev/null; then
#         if sudo apt install -y "$pkg" &>/dev/null; then
#             echo "$pkg installed successfully."
#         else
#             echo "Failed to install $pkg."
#         fi
#     else
#         echo " Package $pkg not found in apt repositories. Skipping."
#     fi
# }

# more verbose function which installs  only if packages are not present and show message if the package is already present .
#.................................................................................................................................................................................
install_package() {
    local pkg="$1"

    if dpkg -s "$pkg" &>/dev/null; then
        echo " $pkg is already installed. Skipping."
    else
        echo -e "\n Installing: $pkg ..."
        if apt-cache show "$pkg" &>/dev/null; then
            if sudo apt install -y "$pkg" &>/dev/null; then
                echo " $pkg installed successfully."
            else
                echo " Failed to install $pkg."
            fi
        else
            echo " Package $pkg not found in apt repositories. Skipping."
        fi
    fi
}

# List of dependencies
packages=(
    i3
    picom
    rofi
    polybar
    i3lock
    alacritty
    feh
    dmenu
    git
    curl
    lxappearance
)

# Update repositories first

# &>/dev/null sends both normal output and error messages to /dev/null, a special file that discards anything written to it
# echo " Updating package lists..."
sudo apt update -y &>/dev/null && echo " Update complete." || echo " Update failed."

# Install each package with verbose feedback
for pkg in "${packages[@]}"; do
    install_package "$pkg"
done

#...............................................................................................


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
