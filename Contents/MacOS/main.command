#!/bin/sh

# main.command

#  Created by Florian Paul Azim Hoberg @gyptazy <gyptazy@gyptazy.ch
#  Copyright (c) 2010 gyptazy, All Rights Reserved.

# Get local path of Application
FILEPATH=$(dirname $0)
CMD_GET_ARCH="$(awk -F '=' '{if (! ($0 ~ /^;/) && $0 ~ /arch/) print $2}' ~/.monkeyswitcher.config)"
BTMAC="$(awk -F '=' '{if (! ($0 ~ /^;/) && $0 ~ /btmac/) print $2}' ~/.monkeyswitcher.config)"

# Test if config file is present 
if [ -f ~/.monkeyswitcher.config ]; then
    echo "Config file found"
else
    osascript -e 'tell application (path to frontmost application as text) to display dialog ".monkeyswitcher.config file is missing. Please create a config." buttons {"OK"} with icon stop'
fi

# Get path to binary for corresponding arch
if [[ "$CMD_GET_ARCH" = "arm64" ]]; then
    BIN="$FILEPATH/blueutil_arm64"
else
    BIN="$FILEPATH/blueutil_amd64"
fi

# Switch device
CMD_VAL="$($BIN --is-connected $BTMAC)"
CMD_UNPAIR="$BIN --unpair $BTMAC"
CMD_PAIR="$BIN --pair $BTMAC"
CMD_CONN="$BIN --connect $BTMAC"
if [[ "$CMD_VAL" -eq 1 ]]; then
    echo "Connected to $BTMAC"
    echo "Going to disconnect $BTMAC"
    $($CMD_UNPAIR)
    if [[ $? -eq 0 ]]; then
        echo "Disconnected from $BTMAC"
    else
        echo "Failed to disconnect from $BTMAC"
        # Workaround for GUI dialog
        osascript -e 'tell application (path to frontmost application as text) to display dialog "Failed to disconnect." buttons {"OK"} with icon stop'
        exit 1
    fi
else
    echo "Not connected to $BTMAC"
    $($CMD_PAIR)
    sleep 1
    $($CMD_CONN)
    if [[ $? -eq 0 ]]; then
        echo "Connected to $BTMAC"
    else
        echo "Failed to connect to $BTMAC"
        # Workaround for GUI dialog
        osascript -e 'tell application (path to frontmost application as text) to display dialog "Failed to connect." buttons {"OK"} with icon stop'
        exit 1
    fi
fi

exit 0
