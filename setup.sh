#!/bin/bash
set -e

echo "=== Installation du shell macOS ==="

# 0. Touch ID pour sudo
echo ">> Configuration de Touch ID pour sudo..."
PAM_SUDO="/etc/pam.d/sudo_local"
if [ ! -f "$PAM_SUDO" ] || ! grep -q "pam_tid.so" "$PAM_SUDO" 2>/dev/null; then
    sudo cp /etc/pam.d/sudo_local.template /etc/pam.d/sudo_local 2>/dev/null || true
    echo "auth       sufficient     pam_tid.so" | sudo tee "$PAM_SUDO" > /dev/null
    echo ">> Touch ID active pour sudo."
else
    echo ">> Touch ID deja configure pour sudo."
fi

# 1. Homebrew
if ! command -v brew &>/dev/null; then
    echo ">> Installation de Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo ">> Homebrew deja installe."
fi

# 2. Outils CLI modernes + Ghostty
echo ">> Installation des outils CLI..."
brew install eza bat fzf zoxide starship sshs bundler-completion
brew install --cask ghostty bunch

# Bun (installeur officiel)
if ! command -v bun &>/dev/null; then
    echo ">> Installation de Bun..."
    curl -fsSL https://bun.sh/install | bash
else
    echo ">> Bun deja installe."
fi

# 3. Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo ">> Installation de Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo ">> Oh My Zsh deja installe."
fi

# 4. Plugins Oh My Zsh
echo ">> Installation des plugins zsh..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] && \
    git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/plugins/zsh-autosuggestions"

[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

[ ! -d "$ZSH_CUSTOM/plugins/fast-syntax-highlighting" ] && \
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git "$ZSH_CUSTOM/plugins/fast-syntax-highlighting"

[ ! -d "$ZSH_CUSTOM/plugins/zsh-autocomplete" ] && \
    git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git "$ZSH_CUSTOM/plugins/zsh-autocomplete"

# 6. .zprofile
echo ">> Configuration de .zprofile..."
cat > "$HOME/.zprofile" << 'EOF'

eval "$(/opt/homebrew/bin/brew shellenv)"
EOF

# 7. .zshrc
echo ">> Configuration de .zshrc..."
cat > "$HOME/.zshrc" << 'ZSHRC'
# =============================================================================
# 1. OH MY ZSH & PLUGINS DE BASE
# =============================================================================
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    fast-syntax-highlighting
    zsh-autocomplete
)

source $ZSH/oh-my-zsh.sh

# =============================================================================
# 2. VARIABLES D'ENVIRONNEMENT & PATH
# =============================================================================
# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# =============================================================================
# 3. ALIAS PERSONNELS & OUTILS MODERNES
# =============================================================================
# eza (Le remplaçant moderne et coloré de 'ls')
alias ls="eza --icons=always --group-directories-first"
alias ll="eza -lh --icons=always --group-directories-first"
alias la="eza -lha --icons=always --group-directories-first"

# bat (Le remplaçant de 'cat' avec coloration syntaxique)
alias cat="bat"

# =============================================================================
# 4. AUTO-COMPLÉTIONS SPÉCIFIQUES
# =============================================================================
# Angular (décommenter si ng est installé)
# source <(ng completion script)

# Bun
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"

# =============================================================================
# 5. INITIALISATION DES NOUVEAUX OUTILS
# =============================================================================
# fzf (Recherche magique avec Ctrl+R)
eval "$(fzf --zsh)"

# zoxide (Le smart 'cd', utilise 'z mon_dossier' au lieu de 'cd')
eval "$(zoxide init zsh)"

# Starship (Ton prompt)
eval "$(starship init zsh)"

ZSHRC

# 8. Ghostty
echo ">> Configuration de Ghostty..."
mkdir -p "$HOME/.config/ghostty"
cat > "$HOME/.config/ghostty/config" << 'GHOSTTY'
# --- Police d'écriture ---
font-family = "JetBrainsMono Nerd Font"
font-size = 14

# --- Thème et Couleurs ---
theme = Catppuccin Mocha

# --- Transparence et Fenêtre (Spécifique macOS) ---
background-opacity = 0.85
background-blur-radius = 20
macos-titlebar-style = transparent
macos-option-as-alt = true

# --- Marges internes ---
window-padding-x = 10
window-padding-y = 10

# --- Curseur ---
cursor-style = block
cursor-style-blink = true
GHOSTTY

# 9. Police JetBrainsMono Nerd Font
if ! ls "$HOME/Library/Fonts"/JetBrainsMonoNerdFont* &>/dev/null 2>&1; then
    echo ">> Installation de JetBrainsMono Nerd Font..."
    brew install --cask font-jetbrains-mono-nerd-font
else
    echo ">> JetBrainsMono Nerd Font deja installee."
fi

echo ""
echo "=== Installation terminee ! ==="
echo "Redemarre ton terminal ou lance : source ~/.zshrc"
