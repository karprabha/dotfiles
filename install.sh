#!/bin/bash
# Bootstrap script for dotfiles
# This will setup Vim, symlinks, and color theme

# -----------------------------
# Function to create symlink
# -----------------------------
link_file() {
    src=$1
    dest=$2
    if [ -e "$dest" ]; then
        echo "Backing up existing file: $dest -> ${dest}.backup"
        mv "$dest" "${dest}.backup"
    fi
    echo "Linking $src -> $dest"
    ln -sf "$src" "$dest"
}

# -----------------------------
# Setup Vim
# -----------------------------
echo "Setting up Vim..."

# Create undo directory if not exists
mkdir -p ~/.vim/undo

# Symlink vimrc
link_file "$PWD/vim/vimrc" ~/.vimrc

# -----------------------------
# Install Gruvbox color theme
# -----------------------------
THEME_DIR="$HOME/.vim/pack/themes/start/gruvbox"

if [ ! -d "$THEME_DIR" ]; then
    echo "Installing Gruvbox color theme..."
    mkdir -p "$(dirname "$THEME_DIR")"
    git clone https://github.com/morhetz/gruvbox.git "$THEME_DIR"
else
    echo "Gruvbox already installed, pulling latest changes..."
    cd "$THEME_DIR" && git pull origin master
fi

echo "Vim setup complete!"
echo "You can now open Vim and Gruvbox will be available."

