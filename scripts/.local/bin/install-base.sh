#!/bin/bash

# Install install/base-packages
mapfile -t packages < <(grep -v '^#' "$HOME/.local/package-lists/base-packages" | grep -v '^$')
sudo pacman -S --noconfirm --needed "${packages[@]}"
