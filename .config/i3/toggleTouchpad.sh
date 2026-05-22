#!/bin/bash

TOUCHPAD=$(xinput list --name-only | grep -i touchpad | head -n1)

STATE=$(xinput list-props "$TOUCHPAD" | awk '/Device Enabled/ {print $4}')

if [ "$STATE" = "1" ]; then
    xinput disable "$TOUCHPAD"
else
    xinput enable "$TOUCHPAD"
fi

