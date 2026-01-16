#!/bin/bash
# Bootstrap script for dotfiles

echo "Linking Vim config..."
mkdir -p ~/.vim/undo
ln -sf ~/workspace/github.com/karprabha/dotfiles/vim/vimrc ~/.vimrc

# Future configs
# ln -sf ~/workspace/github.com/karprabha/dotfiles/tmux/tmux.conf ~/.tmux.conf

echo "Dotfiles linked!"

