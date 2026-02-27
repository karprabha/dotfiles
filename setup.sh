#!/bin/bash
# Full bootstrap: fresh Mac -> configured
# Run: git clone https://github.com/karprabha/dotfiles.git ~/workspace/github.com/karprabha/dotfiles
#      cd ~/workspace/github.com/karprabha/dotfiles && ./setup.sh

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Mac Bootstrap ==="
echo ""

# --- Xcode Command Line Tools ---
if ! xcode-select -p &>/dev/null; then
    echo "Installing Xcode Command Line Tools..."
    xcode-select --install
    echo "Press any key after Xcode CLI tools finish installing..."
    read -n 1
else
    echo "Xcode CLI tools already installed."
fi

# --- Homebrew ---
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "Homebrew already installed."
fi

# --- Brew packages ---
echo "Installing packages from Brewfile..."
brew bundle --file="$DOTFILES_DIR/Brewfile"

# --- Oh My Zsh ---
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My Zsh already installed."
fi

# --- Symlinks ---
echo ""
echo "Setting up symlinks..."
"$DOTFILES_DIR/install.sh"

# --- Workspace directories ---
echo ""
echo "Creating workspace directories..."
mkdir -p ~/workspace/github.com/karprabha
mkdir -p ~/workspace/github.com/againstdata
echo "Created ~/workspace/github.com/{karprabha,againstdata}"

# --- Screenshots directory ---
mkdir -p ~/Screenshots

# --- macOS preferences ---
if [ -f "$DOTFILES_DIR/macos.sh" ]; then
    echo ""
    read -p "Apply macOS system preferences? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        "$DOTFILES_DIR/macos.sh"
    fi
fi

# --- Post-install guidance ---
echo ""
echo "=== Setup Complete ==="
echo ""
echo "Manual steps remaining:"
echo ""
echo "1. SSH Keys:"
echo "   ssh-keygen -t ed25519 -C \"developer.prabhakaryadav@gmail.com\" -f ~/.ssh/github/id_ed25519"
echo "   ssh-keygen -t ed25519 -C \"prabhakar.yadav@againstdata.com\" -f ~/.ssh/github/id_ed25519_work"
echo "   Add public keys to GitHub: https://github.com/settings/keys"
echo ""
echo "2. Node.js (via nvm):"
echo "   nvm install --lts"
echo ""
echo "3. Python (via pyenv):"
echo "   pyenv install 3.12"
echo "   pyenv global 3.12"
echo ""
echo "4. Open a new terminal to load the updated shell config."
