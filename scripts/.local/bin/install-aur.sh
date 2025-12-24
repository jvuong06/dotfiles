#!/bin/bash

# Install install/base-packages
mapfile -t packages < <(grep -v '^#' "$HOME/.local/package-lists/aur-packages" | grep -v '^$')
yay -S --noconfirm --needed "${packages[@]}"
