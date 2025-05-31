#!/bin/bash

# 🧪 Test script for ITrimble's dotfiles
# Verifies that all tools and configurations are working

set -e

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}🧪 Testing ITrimble's Dotfiles Setup${NC}"
echo ""

# Test function
test_command() {
    if command -v "$1" &> /dev/null; then
        echo -e "${GREEN}✅ $1${NC} - $(which $1)"
    else
        echo -e "${RED}❌ $1${NC} - Not found"
    fi
}

# Test aliases
test_alias() {
    if alias "$1" &> /dev/null; then
        echo -e "${GREEN}✅ $1 alias${NC} - $(alias $1 | cut -d'=' -f2-)"
    else
        echo -e "${RED}❌ $1 alias${NC} - Not found"
    fi
}

echo -e "${YELLOW}Testing CLI Tools:${NC}"
test_command "eza"
test_command "bat"
test_command "fd"
test_command "rg"
test_command "fzf"
test_command "lazygit"
test_command "tmux"
test_command "thefuck"
test_command "tree"
test_command "jq"
test_command "gh"

echo ""
echo -e "${YELLOW}Testing Aliases:${NC}"
test_alias "l"
test_alias "lt"
test_alias "cat"
test_alias "find"
test_alias "grep"
test_alias "lg"

echo ""
echo -e "${YELLOW}Testing Functions:${NC}"
if declare -f fe > /dev/null; then
    echo -e "${GREEN}✅ fe function${NC} - Find and edit files"
else
    echo -e "${RED}❌ fe function${NC} - Not found"
fi

if declare -f rg-fzf > /dev/null; then
    echo -e "${GREEN}✅ rg-fzf function${NC} - Search with preview"
else
    echo -e "${RED}❌ rg-fzf function${NC} - Not found"
fi

echo ""
echo -e "${YELLOW}Testing Configuration:${NC}"
if [ -f ~/.zshrc ]; then
    echo -e "${GREEN}✅ .zshrc${NC} - Configuration loaded"
else
    echo -e "${RED}❌ .zshrc${NC} - Not found"
fi

if [ -f ~/.tmux.conf ]; then
    echo -e "${GREEN}✅ .tmux.conf${NC} - Tmux configured"
else
    echo -e "${RED}❌ .tmux.conf${NC} - Not found"
fi

echo ""
echo -e "${BLUE}🎉 Test complete!${NC}"
echo -e "${YELLOW}Try these commands:${NC}"
echo "  l                  # Beautiful file listing"
echo "  lg                 # LazyGit interface"
echo "  fe                 # Find and edit files"
echo "  tmux               # Start terminal multiplexer"
echo "  fuck               # Auto-correct typos"
