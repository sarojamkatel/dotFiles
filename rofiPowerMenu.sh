#!/bin/bash

# A simple Rofi power menu

chosen=$(echo -e " Poweroff\n Reboot\n Suspend\n Lock\n Logout" | rofi -dmenu -i -p "Power Menu")

case "$chosen" in
    " Poweroff") systemctl poweroff ;;
    " Reboot") systemctl reboot ;;
    " Suspend") systemctl suspend ;;
    " Lock") i3lock ;;
    " Logout") i3-msg exit ;;  # Or use `bspc quit` if you're using bspwm
esac

