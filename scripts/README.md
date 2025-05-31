# 🤖 Automated Weekly Maintenance

This system automatically maintains your dotfiles setup with weekly updates and syncing to GitHub.

## 🕒 Schedule

**Every Sunday at 10:00 AM**, the system will:

1. **📦 Update Homebrew** packages and cleanup
2. **🐚 Update Oh My Zsh** framework
3. **🎨 Update Powerlevel10k** theme
4. **🔌 Update zsh plugins** (syntax highlighting, autosuggestions)
5. **🔄 Sync configs** from home directory to dotfiles repo
6. **📥 Pull latest** changes from GitHub
7. **📤 Commit & push** any changes to GitHub
8. **📊 Generate report** with maintenance details
9. **🗑️ Clean up** old logs and backups

## 🚀 Setup

### **Install Automation**
```bash
cd ~/.dotfiles/scripts
./setup-automation.sh
```

### **Manual Test Run**
```bash
cd ~/.dotfiles/scripts
./weekly-maintenance.sh
```

## 📁 File Structure

```
~/.dotfiles/scripts/
├── weekly-maintenance.sh              # Main automation script
├── setup-automation.sh                # Installation script
├── com.itrimble.dotfiles.maintenance.plist  # LaunchAgent config
└── README.md                          # This documentation

~/.dotfiles/logs/
├── maintenance-YYYYMMDD-HHMMSS.log    # Detailed execution logs
├── maintenance-report-YYYYMMDD.md     # Weekly reports
├── launchd-stdout.log                 # LaunchAgent output
└── launchd-stderr.log                 # LaunchAgent errors

~/.dotfiles/backups/
└── YYYYMMDD-HHMMSS/                   # Timestamped config backups
    ├── .zshrc
    ├── .tmux.conf
    ├── .gitconfig
    └── .p10k.zsh
```

## 🔧 Management

### **Check Status**
```bash
# View scheduled jobs
launchctl list | grep dotfiles

# Check if automation is loaded
launchctl list com.itrimble.dotfiles.maintenance
```

### **View Logs**
```bash
# Real-time log monitoring
tail -f ~/.dotfiles/logs/launchd-stdout.log

# View latest maintenance report
ls -t ~/.dotfiles/logs/maintenance-report-*.md | head -1 | xargs cat
```

### **Control Automation**
```bash
# Disable weekly automation
launchctl unload ~/Library/LaunchAgents/com.itrimble.dotfiles.maintenance.plist

# Re-enable weekly automation  
launchctl load ~/Library/LaunchAgents/com.itrimble.dotfiles.maintenance.plist

# Remove automation completely
rm ~/Library/LaunchAgents/com.itrimble.dotfiles.maintenance.plist
```
