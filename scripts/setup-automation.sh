#!/bin/bash

# 🕒 Setup Automated Weekly Maintenance
# Installs LaunchAgent for automatic weekly updates

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

DOTFILES_DIR="$HOME/.dotfiles"
SCRIPTS_DIR="$DOTFILES_DIR/scripts"
PLIST_NAME="com.itrimble.dotfiles.maintenance.plist"
LAUNCH_AGENTS_DIR="$HOME/Library/LaunchAgents"

echo "🕒 Setting up Automated Weekly Dotfiles Maintenance"
echo ""

# Verify dotfiles directory exists
if [ ! -d "$DOTFILES_DIR" ]; then
    log_error "Dotfiles directory not found at $DOTFILES_DIR"
    exit 1
fi

# Create necessary directories
log_info "Creating necessary directories..."
mkdir -p "$DOTFILES_DIR/logs"
mkdir -p "$DOTFILES_DIR/backups"
mkdir -p "$LAUNCH_AGENTS_DIR"

# Make the maintenance script executable
log_info "Making maintenance script executable..."
chmod +x "$SCRIPTS_DIR/weekly-maintenance.sh"

# Install LaunchAgent
log_info "Installing LaunchAgent for weekly automation..."
cp "$SCRIPTS_DIR/$PLIST_NAME" "$LAUNCH_AGENTS_DIR/"

# Load the LaunchAgent
log_info "Loading LaunchAgent..."
launchctl unload "$LAUNCH_AGENTS_DIR/$PLIST_NAME" 2>/dev/null || true
launchctl load "$LAUNCH_AGENTS_DIR/$PLIST_NAME"

# Verify the LaunchAgent is loaded
if launchctl list | grep -q "com.itrimble.dotfiles.maintenance"; then
    log_success "LaunchAgent successfully loaded and scheduled"
else
    log_error "Failed to load LaunchAgent"
    exit 1
fi

echo ""
log_success "✅ Automated maintenance setup complete!"
echo ""
echo "📋 Configuration:"
echo "   Schedule: Every Sunday at 10:00 AM"
echo "   Script: $SCRIPTS_DIR/weekly-maintenance.sh"
echo "   Logs: $DOTFILES_DIR/logs/"
echo "   Backups: $DOTFILES_DIR/backups/"
echo ""
echo "🧪 Test the automation:"
echo "   Manual run: $SCRIPTS_DIR/weekly-maintenance.sh"
echo "   Check status: launchctl list | grep dotfiles"
echo "   View logs: tail -f $DOTFILES_DIR/logs/launchd-stdout.log"
echo ""
echo "🔄 Management commands:"
echo "   Disable: launchctl unload $LAUNCH_AGENTS_DIR/$PLIST_NAME"
echo "   Enable:  launchctl load $LAUNCH_AGENTS_DIR/$PLIST_NAME"
echo "   Remove:  rm $LAUNCH_AGENTS_DIR/$PLIST_NAME"
