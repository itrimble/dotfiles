# 🚀 ITrimble's Dotfiles

> **Supercharged macOS development environment optimized for Apple Silicon**

A complete, automated setup for a modern macOS development environment featuring lightning-fast startup times, beautiful CLI tools, and productivity-focused configurations.

## ✨ Features

### ⚡ **Performance Optimized**
- **3x faster** zsh startup (~0.26s vs ~0.8s)
- ARM64-first PATH configuration
- Smart completion caching
- Optimized plugin loading

### 🛠️ **Modern CLI Tools**
- **`eza`** - Beautiful file listings with icons
- **`bat`** - Syntax highlighted file viewer
- **`fd`** - Lightning-fast file finder
- **`ripgrep`** - Ultra-fast text search
- **`fzf`** - Fuzzy finder with previews
- **`lazygit`** - Gorgeous Git interface
- **`tmux`** - Terminal multiplexer
- **`thefuck`** - Auto-correct command typos

### 🎨 **Beautiful Interface**
- **Powerlevel10k** theme with instant prompt
- **Syntax highlighting** in terminal
- **Auto-suggestions** based on history
- **Icons and colors** throughout

### 🚀 **Productivity Features**
- **Smart aliases** for common tasks
- **Enhanced functions** with fuzzy finding
- **Application integrations** (Alfred, CleanShot X, VS Code)
- **Docker shortcuts** and Git workflow helpers

## 📦 Installation

### **One-Line Install**
```bash
git clone https://github.com/itrimble/dotfiles.git ~/.dotfiles && cd ~/.dotfiles && ./install.sh
```

### **Step-by-Step**
```bash
# Clone the repository
git clone https://github.com/itrimble/dotfiles.git ~/.dotfiles

# Navigate to the directory
cd ~/.dotfiles

# Run the installation script
./install.sh

# Restart your terminal or reload config
source ~/.zshrc
```

## 🎯 What Gets Installed

### **Homebrew Packages**
```
eza bat fd ripgrep fzf tree lazygit tmux thefuck tldr neofetch
git gh jq curl wget htop
```

### **Zsh Environment**
- Oh My Zsh framework
- Powerlevel10k theme
- zsh-syntax-highlighting plugin
- zsh-autosuggestions plugin
- Custom aliases and functions

### **Configuration Files**
- `.zshrc` - Optimized shell configuration
- `.tmux.conf` - Terminal multiplexer settings
- `.gitconfig` - Git configuration
- `.p10k.zsh` - Powerlevel10k theme settings

## 🛠️ Key Aliases & Functions

### **File Operations**
```bash
l           # eza -la --icons (beautiful file listing)
lt          # eza --tree --level=2 --icons (tree view)
lta         # eza --tree --level=3 --icons -a (tree with hidden)
cat         # bat (syntax highlighted viewing)
find        # fd (faster file finding)
grep        # rg (ultra-fast text search)
```

### **Git Workflow**
```bash
gs          # git status
gc          # git commit
gp          # git push
gl          # git log --oneline --graph --decorate
gco         # git checkout
gb          # git branch
lg          # lazygit (beautiful Git interface)
```

### **Enhanced Functions**
```bash
fe              # Find and edit files with fzf
rg-fzf "text"   # Search text with preview
gb-switch       # Git branch switcher with fzf
pk              # Process killer with fzf
mkcd dirname    # Create and enter directory
serve 8000      # Start HTTP server
```

### **App Shortcuts**
```bash
code            # Open VS Code (enhanced)
subl            # Open Sublime Text (enhanced)
chrome          # Launch Google Chrome
alfred "query"  # Search with Alfred
cleanshot       # Open CleanShot X
docker-ps       # Docker process list
docker-clean    # Clean Docker system
```

### **System Utilities**
```bash
path            # View PATH in numbered list
brewup          # Update, upgrade, cleanup Homebrew
sysinfo         # Show system info with neofetch
fuck            # Auto-correct last command
..              # cd ..
...             # cd ../..
```

## 🔧 Customization

### **Adding Your Own Aliases**
Edit `.zshrc` and add your custom aliases in the designated section:
```bash
# 🎯 Personal Aliases
alias myalias='command'
```

### **PATH Modifications**
The PATH is optimized for ARM64 Macs with this priority:
```
~/.local/bin → ~/bin → /opt/homebrew/bin → /usr/local/bin → system paths
```

## 📋 Requirements

- **macOS** (tested on Sequoia)
- **Zsh** (default on macOS)
- **Internet connection** for downloads
- **Xcode Command Line Tools** (installed automatically)

## 🚀 Performance

**Before:** ~0.8s zsh startup time  
**After:** ~0.26s zsh startup time (**3x faster!**)

## 🤝 Contributing

Feel free to fork and customize for your own needs! Pull requests welcome.

## 📄 License

MIT License - Feel free to use and modify as needed.

---

**Happy coding!** 🚀✨
