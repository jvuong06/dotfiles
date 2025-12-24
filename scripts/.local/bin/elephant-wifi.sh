#!/bin/bash

# Get the wireless device name (usually wlan0)
DEVICE=$(iwctl device list | grep -oE "wlan[0-9]+")

if [[ "$1" == "--connect" ]]; then
    # Action: Connect to the selected SSID
    iwctl station "$DEVICE" connect "$2"
    exit 0
fi

# Query: List available networks
# We skip the header lines and extract the SSID
iwctl station "$DEVICE" get-networks | awk 'NR>4 {print $2}' | while read -r ssid; do
    # Format for Elephant (Title | Subtitle | Command)
    echo "$ssid | Wireless Network | ~/.local/bin/elephant-wifi.sh --connect $ssid"
done
