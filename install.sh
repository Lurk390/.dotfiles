#!/usr/bin/env bash
set -e

echo "[*] Installing prerequisites..."
if command -v apt >/dev/null 2>&1; then
    sudo apt update
    sudo apt install -y \
        zsh git curl fzf ripgrep
elif command -v dnf >/dev/null 2>&1; then
    sudo dnf install -y \
        zsh git curl fzf ripgrep
elif command -v pacman >/dev/null 2>&1; then
    sudo pacman -Syu --noconfirm \
        zsh git curl fzf ripgrep
else
    echo "[-] Package manager not detected. Install zsh, git, curl, fzf, ripgrep manually."
    exit 1
fi

echo "[*] Installing Oh My Zsh..."
export RUNZSH=no  # don't auto-start zsh yet
export CHSH=no    # don't change default shell automatically
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

echo "[*] Installing plugins..."
# zsh-autosuggestions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions \
        "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# zsh-syntax-highlighting
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

echo "[*] Installing zoxide..."
if ! command -v zoxide >/dev/null 2>&1; then
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
    mkdir -p "$HOME/.local/bin"
    mv zoxide "$HOME/.local/bin" 2>/dev/null || true
fi

echo "[*] Installing starship..."
if ! command -v starship >/dev/null 2>&1; then
    curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

echo "[*] Installation complete!"
echo "Run 'chsh -s $(which zsh)' to make zsh your default shell (then log out and back in)."
