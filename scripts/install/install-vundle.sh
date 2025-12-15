#!/bin/bash

VIM_DIR="$HOME/.vim"
VUNDLE_DIR="$VIM_DIR/bundle/Vundle.vim"

if ! [[ -d $VIM_DIR ]]; then
    echo "Vim is not installed or not in default directory"
    exit 1
fi

if ! command -v git &>/dev/null; then 
    echo "Git is not installed or is missing from path"
    exit 1
fi 

if ! [[ -d $VUNDLE_DIR ]]; then 
    echo "Installing Vundle..."
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
else
    echo "Vundle is already installed for this Vim installation"
fi
