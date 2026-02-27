#!/bin/bash
# Symlink manager for dotfiles (idempotent, standalone)

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# --- Symlink helper ---
link_file() {
    local src="$1"
    local dest="$2"

    if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
        echo "Already linked: $dest"
        return
    fi

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        local backup="${dest}.backup.$(date +%Y%m%d%H%M%S)"
        echo "Backing up: $dest -> $backup"
        mv "$dest" "$backup"
    fi

    mkdir -p "$(dirname "$dest")"
    ln -sf "$src" "$dest"
    echo "Linked: $src -> $dest"
}

# --- Vim ---
echo "Setting up Vim..."
mkdir -p ~/.vim/undo

link_file "$DOTFILES_DIR/vim/vimrc" ~/.vimrc

THEME_DIR="$HOME/.vim/pack/themes/start/gruvbox"
if [ ! -d "$THEME_DIR" ]; then
    echo "Installing Gruvbox color theme..."
    mkdir -p "$(dirname "$THEME_DIR")"
    git clone https://github.com/morhetz/gruvbox.git "$THEME_DIR"
else
    echo "Gruvbox already installed."
fi

# --- Ghostty ---
echo "Setting up Ghostty..."
link_file "$DOTFILES_DIR/ghostty/config" ~/.config/ghostty/config

# --- Zsh ---
echo "Setting up Zsh..."
link_file "$DOTFILES_DIR/zsh/zshrc" ~/.zshrc

# --- Git ---
echo "Setting up Git..."
link_file "$DOTFILES_DIR/git/gitconfig" ~/.gitconfig
link_file "$DOTFILES_DIR/git/gitconfig-work" ~/.gitconfig-work
link_file "$DOTFILES_DIR/git/gitignore_global" ~/.gitignore_global

# --- SSH ---
echo "Setting up SSH..."
mkdir -p ~/.ssh && chmod 700 ~/.ssh
link_file "$DOTFILES_DIR/ssh/config" ~/.ssh/config

echo ""
echo "All symlinks installed!"
