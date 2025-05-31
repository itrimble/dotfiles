#!/bin/bash

# 🔄 Update script for ITrimble's dotfiles
# Run this to update your dotfiles to the latest version

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}🔄 Updating ITrimble's Dotfiles${NC}"

# Navigate to dotfiles directory
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DOTFILES_DIR"

# Pull latest changes
echo -e "${YELLOW}Pulling latest changes...${NC}"
git pull origin main

# Update Homebrew packages
echo -e "${YELLOW}Updating Homebrew packages...${NC}"
brew update
brew upgrade

# Update Oh My Zsh
echo -e "${YELLOW}Updating Oh My Zsh...${NC}"
if [ -d "$HOME/.oh-my-zsh" ]; then
    cd "$HOME/.oh-my-zsh"
    git pull origin master
    cd "$DOTFILES_DIR"
fi

# Update Powerlevel10k
echo -e "${YELLOW}Updating Powerlevel10k...${NC}"
P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [ -d "$P10K_DIR" ]; then
    cd "$P10K_DIR"
    git pull origin master
    cd "$DOTFILES_DIR"
fi

# Update plugins
echo -e "${YELLOW}Updating zsh plugins...${NC}"
ZSH_PLUGINS_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"

for plugin in zsh-syntax-highlighting zsh-autosuggestions; do
    if [ -d "$ZSH_PLUGINS_DIR/$plugin" ]; then
        cd "$ZSH_PLUGINS_DIR/$plugin"
        git pull origin master
        cd "$DOTFILES_DIR"
    fi
done

# Reload zsh configuration
echo -e "${YELLOW}Reloading configuration...${NC}"
source ~/.zshrc

echo -e "${GREEN}✅ Update complete!${NC}"
echo -e "${BLUE}Restart your terminal to ensure all changes take effect.${NC}"
