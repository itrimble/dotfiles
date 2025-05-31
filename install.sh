#!/bin/bash

# 🚀 ITrimble's Dotfiles - Automated Setup Script
# Optimized for Apple Silicon macOS
# https://github.com/itrimble/dotfiles

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Logging functions
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
log_header() { echo -e "${PURPLE}[HEADER]${NC} $1"; }

# Script directory
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%s)"

log_header "🚀 Setting up ITrimble's Optimized macOS Environment"
log_info "Dotfiles directory: $DOTFILES_DIR"
log_info "Backup directory: $BACKUP_DIR"

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Function to backup existing files
backup_file() {
    if [ -f "$1" ] || [ -L "$1" ]; then
        log_warning "Backing up existing $1"
        cp "$1" "$BACKUP_DIR/"
    fi
}

# Function to link dotfiles
link_dotfile() {
    local src="$DOTFILES_DIR/$1"
    local dest="$HOME/$1"
    
    if [ -f "$src" ]; then
        backup_file "$dest"
        ln -sf "$src" "$dest"
        log_success "Linked $1"
    else
        log_warning "Source file $src not found"
    fi
}

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    log_error "This script is designed for macOS only!"
    exit 1
fi

# Check for Apple Silicon
if [[ $(uname -m) == "arm64" ]]; then
    log_success "Apple Silicon detected - using ARM64 optimizations"
    HOMEBREW_PREFIX="/opt/homebrew"
else
    log_info "Intel Mac detected - using x86_64 optimizations"
    HOMEBREW_PREFIX="/usr/local"
fi

# Install Homebrew if not present
log_header "📦 Installing Homebrew"
if ! command -v brew &> /dev/null; then
    log_info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for this session
    if [[ $(uname -m) == "arm64" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        eval "$(/usr/local/bin/brew shellenv)"
    fi
else
    log_success "Homebrew already installed"
fi

# Update Homebrew
log_info "Updating Homebrew..."
brew update

# Install essential packages
log_header "🛠️ Installing Essential Packages"
packages=(
    # Modern CLI tools
    "eza"           # Better ls
    "bat"           # Better cat
    "fd"            # Better find
    "ripgrep"       # Better grep
    "fzf"           # Fuzzy finder
    "tree"          # Directory tree
    "lazygit"       # Git TUI
    "tmux"          # Terminal multiplexer
    "thefuck"       # Command correction
    "tldr"          # Simplified man pages
    "neofetch"      # System info
    
    # Development tools
    "git"           # Version control
    "gh"            # GitHub CLI
    "jq"            # JSON processor
    "curl"          # Data transfer
    "wget"          # File downloader
    "htop"          # Process viewer
)

for package in "${packages[@]}"; do
    if brew list "$package" &>/dev/null; then
        log_success "$package already installed"
    else
        log_info "Installing $package..."
        brew install "$package"
    fi
done

# Install Oh My Zsh if not present
log_header "🐚 Setting up Zsh Environment"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    log_info "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    log_success "Oh My Zsh already installed"
fi

# Install Powerlevel10k theme
P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [ ! -d "$P10K_DIR" ]; then
    log_info "Installing Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
else
    log_success "Powerlevel10k already installed"
fi

# Install zsh plugins
ZSH_PLUGINS_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"

# zsh-syntax-highlighting
if [ ! -d "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting" ]; then
    log_info "Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting"
else
    log_success "zsh-syntax-highlighting already installed"
fi

# zsh-autosuggestions
if [ ! -d "$ZSH_PLUGINS_DIR/zsh-autosuggestions" ]; then
    log_info "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_PLUGINS_DIR/zsh-autosuggestions"
else
    log_success "zsh-autosuggestions already installed"
fi

# Link dotfiles
log_header "🔗 Linking Dotfiles"
link_dotfile ".zshrc"
link_dotfile ".tmux.conf"
link_dotfile ".gitconfig"
link_dotfile ".p10k.zsh"

# Make directories if they don't exist
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/bin"

# Set executable permissions
chmod +x "$DOTFILES_DIR/install.sh"

# Final steps
log_header "🎉 Setup Complete!"
log_success "Dotfiles installed successfully!"
log_info "Backup created at: $BACKUP_DIR"
log_info ""
log_info "Next steps:"
log_info "1. Restart your terminal or run: source ~/.zshrc"
log_info "2. Configure p10k theme: p10k configure"
log_info "3. Enjoy your optimized setup!"
log_info ""
log_info "Test your setup with:"
log_info "  l          # Beautiful file listing"
log_info "  lg         # LazyGit interface"
log_info "  fe         # Find and edit files"
log_info "  rg-fzf     # Search with preview"
log_info ""
log_success "Happy coding! 🚀"
