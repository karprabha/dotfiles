#!/bin/bash
# macOS system preferences
# Run manually or via setup.sh

echo "Applying macOS preferences..."

# --- Finder ---
# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# --- Keyboard ---
# Fast key repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2

# Short delay until repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Disable press-and-hold for keys (enable key repeat)
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# --- Screenshots ---
# Save screenshots to ~/Screenshots
defaults write com.apple.screencapture location -string "$HOME/Screenshots"

# --- Dock ---
# Autohide dock
defaults write com.apple.dock autohide -bool true

# Remove dock autohide delay
defaults write com.apple.dock autohide-delay -float 0

# --- Apply changes ---
killall Finder 2>/dev/null || true
killall Dock 2>/dev/null || true
killall SystemUIServer 2>/dev/null || true

echo "macOS preferences applied. Some changes may require a logout."
