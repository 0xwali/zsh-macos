# macOS Zsh Setup

Script d'installation automatique pour configurer un terminal macOS from scratch avec Zsh, Oh My Zsh, Ghostty et des outils CLI modernes.

## Ce qui est installe

### Terminal

| Outil | Description |
|-------|-------------|
| [Ghostty](https://ghostty.org) | Terminal rapide et moderne |
| [Starship](https://starship.rs) | Prompt minimaliste et personnalisable |
| [JetBrainsMono Nerd Font](https://www.nerdfonts.com) | Police avec icones integrees |

### Shell (Zsh)

| Outil | Description |
|-------|-------------|
| [Oh My Zsh](https://ohmyz.sh) | Framework de configuration zsh |
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) | Suggestions basees sur l'historique |
| [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) | Coloration syntaxique en temps reel |
| [fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting) | Coloration syntaxique avancee et rapide |
| [zsh-autocomplete](https://github.com/marlonrichert/zsh-autocomplete) | Autocompletion en temps reel |

### Outils CLI

| Commande | Remplace | Description |
|----------|----------|-------------|
| [eza](https://github.com/eza-community/eza) | `ls` | Listing avec icones et couleurs |
| [bat](https://github.com/sharkdp/bat) | `cat` | Affichage avec coloration syntaxique |
| [fzf](https://github.com/junegunn/fzf) | `Ctrl+R` | Recherche floue interactive |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | `cd` | Navigation intelligente (`z mon_dossier`) |
| [Bun](https://bun.sh) | `node/npm` | Runtime JavaScript rapide |
| [sshs](https://github.com/quantumsheep/sshs) | `ssh` | Interface TUI pour les hosts SSH |
| [bundler-completion](https://github.com/mernen/completion-ruby) | - | Autocompletion pour Bundler |
| [Bunch](https://bunchapp.co) | - | Automatisation d'apps macOS |

### Config Ghostty

- Theme : **Catppuccin Mocha**
- Police : **JetBrainsMono Nerd Font** (taille 14)
- Transparence : 85% avec blur
- Barre de titre transparente
- Curseur : block clignotant

## Prerequis

- macOS (Apple Silicon ou Intel)
- Connexion internet
- Droits administrateur

## Installation

### One-liner

```bash
curl -fsSL https://raw.githubusercontent.com/0xwali/zsh-macos/main/setup.sh | bash
```

### Depuis le repo

```bash
git clone https://github.com/0xwali/zsh-macos.git && cd zsh-macos
chmod +x setup.sh
./setup.sh
```

Puis relancer le terminal.

## Fichiers configures

| Fichier | Role |
|---------|------|
| `~/.zprofile` | Initialisation Homebrew |
| `~/.zshrc` | Config shell, alias, plugins |
| `~/.config/ghostty/config` | Config terminal Ghostty |

## Alias disponibles

```bash
ls       # eza avec icones
ll       # liste detaillee
la       # liste detaillee + fichiers caches
cat      # bat avec coloration syntaxique
z <dir>  # navigation intelligente (zoxide)
```

## Personnalisation

- **Angular** : decommenter `source <(ng completion script)` dans `~/.zshrc` si necessaire
- **Starship** : creer `~/.config/starship.toml` pour personnaliser le prompt
- **Ghostty** : editer `~/.config/ghostty/config`
