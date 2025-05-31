#!/bin/bash

# 📊 Check Dotfiles Automation Status
# Quick status check for weekly maintenance automation

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "🤖 Dotfiles Automation Status"
echo "============================="

# Check if LaunchAgent is loaded
if launchctl list | grep -q "com.itrimble.dotfiles.maintenance"; then
    echo -e "Status: ${GREEN}✅ Active${NC}"
    echo -e "Schedule: ${BLUE}Every Sunday at 10:00 AM${NC}"
else
    echo -e "Status: ${RED}❌ Not Active${NC}"
    echo -e "Run: ${YELLOW}./setup-automation.sh${NC} to enable"
fi

echo ""

# Check for recent logs
LATEST_LOG=$(ls -t ~/.dotfiles/logs/maintenance-*.log 2>/dev/null | head -1)
if [ -n "$LATEST_LOG" ]; then
    echo "📋 Latest Maintenance:"
    echo "   Date: $(basename "$LATEST_LOG" | sed 's/maintenance-//; s/-.*.log//; s/\(..\)\(..\)\(..\)/20\3-\1-\2/')"
    echo "   Log: $LATEST_LOG"
else
    echo "📋 No maintenance logs found"
fi

echo ""

# Check for recent reports
LATEST_REPORT=$(ls -t ~/.dotfiles/logs/maintenance-report-*.md 2>/dev/null | head -1)
if [ -n "$LATEST_REPORT" ]; then
    echo "📊 Latest Report: $LATEST_REPORT"
else
    echo "📊 No maintenance reports found"
fi

echo ""
echo "🔧 Management Commands:"
echo "   Status: ./status.sh"
echo "   Manual run: ./weekly-maintenance.sh"
echo "   Setup: ./setup-automation.sh"
echo "   Logs: tail -f ~/.dotfiles/logs/launchd-stdout.log"
