#!/bin/bash

FILE="/etc/NetworkManager/conf.d/wifi_backend.conf"

if [[ ! -f $FILE ]]; then
    sudo tee -a $FILE > /dev/null << \
EOF
[device]
wifi.backend=iwd
EOF
else
    echo "Error: A file to configure NetworkManager's backend already exists"
fi
