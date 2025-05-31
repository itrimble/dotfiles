# ---------------------------------------
#        🚀 Enhanced ZSH Config - OPTIMIZED
#        Updated: $(date +"%Y-%m-%d")
#        Changes: PATH optimization, ARM64 priority, enhanced functions
# ---------------------------------------

# ✅ Powerlevel10k Instant Prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set path to Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
export ZSH_DISABLE_COMPFIX=true

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins - Enhanced with modern tools
plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
  z
  zsh-interactive-cd
  docker
  npm
  zsh-colorls
  fzf
  eza
  extract
  colored-man-pages
  command-not-found
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Powerlevel10k config
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ⌨️ Auto-suggestion key bindings
bindkey '^ ' autosuggest-accept
bindkey '^N' autosuggest-next
bindkey '^P' autosuggest-previous

# 📁 PATH Setup - Optimized for ARM64 Mac
# Priority order: Personal bins → ARM64 Homebrew → Intel Homebrew → System
export PATH="$HOME/.local/bin:$HOME/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"

# 🧑‍💻 Development tool paths (add only if tools are installed)
[[ -d "/opt/homebrew/opt/python@3.12/bin" ]] && export PATH="/opt/homebrew/opt/python@3.12/bin:$PATH"
[[ -d "/opt/homebrew/opt/ruby/bin" ]] && export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
[[ -d "/opt/homebrew/opt/llvm/bin" ]] && export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
[[ -d "$HOME/.cargo/bin" ]] && export PATH="$HOME/.cargo/bin:$PATH"

# 🧠 Editor & Development Environment
export EDITOR="nvim"
export VISUAL="$EDITOR"
export PAGER="less"

# 🏗️ Build optimizations for Apple Silicon
export ARCHFLAGS="-arch arm64"
export CMAKE_OSX_ARCHITECTURES="arm64"

# 📦 Package manager optimizations
export HOMEBREW_NO_AUTO_UPDATE=1     # Prevent auto-updates during install
export HOMEBREW_NO_ANALYTICS=1       # Disable analytics
export HOMEBREW_NO_INSTALL_CLEANUP=1 # Keep older versions
export HOMEBREW_NO_ENV_HINTS=1       # Disable environment hints
export NPM_CONFIG_FUND=false         # Disable npm funding messages
export NPM_CONFIG_AUDIT=false        # Disable security audits for speed
export PYTHON_CONFIGURE_OPTS="--enable-framework"  # Better Python builds

# 🚀 Performance optimizations
export DISABLE_AUTO_TITLE="true"     # Don't auto-set terminal title
export COMPLETION_WAITING_DOTS="true" # Show dots while waiting for completion

# 🛠️ Enhanced Aliases
alias l='eza -la --icons'
alias ll='eza -alF --icons'
alias la='eza -A --icons'
alias lt='eza --tree --level=2 --icons'
alias lta='eza --tree --level=3 --icons -a'
alias ls='eza --icons'
alias cat='bat'
alias find='fd'
alias grep='rg'
alias tree='eza --tree --icons'
alias gs='git status'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
alias gco='git checkout'
alias gb='git branch'
alias lg='lazygit'
alias zshconfig='code ~/.zshrc'
alias reloadzsh='source ~/.zshrc'
alias brewup='brew update && brew upgrade && brew cleanup'
alias npmglobal='npm list -g --depth=0'
alias path='echo $PATH | tr ":" "\n" | nl'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'

# 🧭 Autojump (if installed)
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

# 🔍 FZF Configuration
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --inline-info'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--preview "bat --color=always --style=numbers --line-range=:500 {}"'
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_ALT_C_OPTS='--preview "eza --tree --level=1 --icons {}"'

# FZF key bindings and completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ] && source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
[ -f /opt/homebrew/opt/fzf/shell/completion.zsh ] && source /opt/homebrew/opt/fzf/shell/completion.zsh

# 🚀 TheFuck - Auto-correct previous command
eval $(thefuck --alias)
eval $(thefuck --alias fk)  # Shorter alias

# 🔧 Useful Functions
# Create and enter directory
mkcd() { mkdir -p "$1" && cd "$1"; }

# Enhanced search with ripgrep and fzf
rg-fzf() {
  rg --color=always --line-number --no-heading --smart-case "${*:-}" |
    fzf --ansi \
        --color "hl:-1:underline,hl+:-1:underline:reverse" \
        --delimiter : \
        --preview 'bat --color=always {1} --highlight-line {2}' \
        --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
        --bind 'enter:become(nvim {1} +{2})'
}

# Find and edit files quickly
fe() {
  local files
  IFS=$'\n' files=($(fzf --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-nvim} "${files[@]}"
}

# Git branch switcher with fzf
gb-switch() {
  git branch -a | grep -v HEAD | sed 's/.* //' | sed 's#remotes/[^/]*/##' | sort -u | fzf | xargs git checkout
}

# Process killer with fzf
pk() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
  if [ "x$pid" != "x" ]; then
    echo $pid | xargs kill -${1:-9}
  fi
}

# Quick server for current directory
serve() { python3 -m http.server ${1:-8000}; }

# 📱 Application Integrations
# Open in VS Code
code() {
  if [ $# -eq 0 ]; then
    /usr/local/bin/code .
  else
    /usr/local/bin/code "$@"
  fi
}

# Open in Sublime Text
subl() {
  if [ $# -eq 0 ]; then
    /usr/local/bin/subl .
  else
    /usr/local/bin/subl "$@"
  fi
}

# CleanShot X screenshot
screenshot() {
  open -a "CleanShot X"
}

# System info with neofetch
sysinfo() {
  neofetch
}

# Docker shortcuts
docker-ps() { docker ps "$@"; }
docker-img() { docker images "$@"; }
docker-run() { docker run -it --rm "$@"; }
docker-stop() { docker stop $(docker ps -q); }
docker-clean() { docker system prune -f; }

# Alfred workflow trigger
alfred() {
  osascript -e "tell application \"Alfred 5\" to search \"$1\""
}

# 🖥️ iTerm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# ✅ Explicitly source Homebrew-installed plugins
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# 💤 Quiet Powerlevel10k instant prompt warning
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# 🏎️ Optimized Completions
# Only rebuild completions if needed
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

# Enhanced completion styles
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:corrections' format '%F{green}%d (errors: %e)%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'

# 🟡 Bun JavaScript runtime
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "/Users/ian/.bun/_bun" ] && source "/Users/ian/.bun/_bun"  # Bun completions

# 🐋 Docker completions
fpath=(/Users/ian/.docker/completions $fpath)

# Add Homebrew completions to fpath
fpath+=(/opt/homebrew/share/zsh/site-functions ~/.zfunc)

# 🎯 App-Specific Shortcuts & Configs
# Quick app launchers
alias chrome='open -a "Google Chrome"'
alias firefox='open -a "Firefox"'
alias brave='open -a "Brave Browser"'
alias xcode='open -a "Xcode"'
alias docker-gui='open -a "Docker"'
alias cleanshot='open -a "CleanShot X"'
alias alfred='open -a "Alfred 5"'

# Development shortcuts
alias ios-sim='open -a Simulator'
alias activity='open -a "Activity Monitor"'
alias keychain='open -a "Keychain Access"'
# End of Docker CLI completions
