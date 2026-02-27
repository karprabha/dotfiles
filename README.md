# Dotfiles

Personal Mac configuration — one command to set up a fresh machine.

## Quick Start

```bash
# Fresh Mac
git clone https://github.com/karprabha/dotfiles.git ~/workspace/github.com/karprabha/dotfiles
cd ~/workspace/github.com/karprabha/dotfiles
./setup.sh
```

```bash
# Existing Mac (symlinks only)
cd ~/workspace/github.com/karprabha/dotfiles
./install.sh
```

## What's Managed

| File | Source | Target |
|------|--------|--------|
| `vim/vimrc` | Vim config | `~/.vimrc` |
| `ghostty/config` | Ghostty terminal | `~/.config/ghostty/config` |
| `zsh/zshrc` | Zsh shell config | `~/.zshrc` |
| `git/gitconfig` | Git config | `~/.gitconfig` |
| `git/gitconfig-work` | Work Git overrides | `~/.gitconfig-work` |
| `git/gitignore_global` | Global gitignore | `~/.gitignore_global` |
| `ssh/config` | SSH hosts | `~/.ssh/config` |

## Scripts

- **`setup.sh`** — Full bootstrap (Xcode CLI, Homebrew, Oh My Zsh, packages, symlinks)
- **`install.sh`** — Symlink manager only (idempotent, safe to re-run)
- **`macos.sh`** — macOS system preferences (Finder, keyboard, screenshots)

## Machine-Specific Overrides

For settings that differ between machines (not tracked in git):

- `~/.zshrc.local` — sourced at the end of `.zshrc`
- `~/.gitconfig.local` — included at the end of `.gitconfig`

## Maintenance

```bash
# Added a new brew package
brew install <pkg>
brew bundle dump --file=~/workspace/github.com/karprabha/dotfiles/Brewfile --force

# Audit: show installed packages not in Brewfile
brew bundle cleanup --file=~/workspace/github.com/karprabha/dotfiles/Brewfile

# Config change: edit in repo (symlinks mean instant effect), then commit
```
