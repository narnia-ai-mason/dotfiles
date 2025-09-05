export LANG=C.UTF-8

export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history
export HISTCONTROL=ignoredups:erasedups


# Install required cli tools if not already installed
if [[ ! -f "$HOME/.cli_tools_installed" ]]; then
  curl -fsSL https://raw.githubusercontent.com/narnia-ai-mason/cli-tools-installer/main/install.sh | bash
fi

# Configure node version manager (nvm)
if [[ -d "$HOME/.nvm" ]]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

# Configure Starship
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

# Configure fzf
if command -v fzf &> /dev/null; then
  source <(fzf --zsh)
  export FZF_DEFAULT_OPTIONS='--height 40% --layout=reverse --border'
fi

# Configure zoxide for enhanced cd
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
  # alias cd='z'
fi

# Configure eza for enhanced ls
if command -v eza &> /dev/null; then
  alias ls='eza'
  alias ll='eza -lh'
  alias la='eza -lha'
fi

# Configure bat for enhanced cat
if command -v bat &> /dev/null; then
  alias cat='bat'
fi

# Configure ripgrep for enhanced grep
if command -v rg &> /dev/null; then
  alias grep='rg'
fi

# Configure fd for enhanced find
if command -v fd &> /dev/null; then
  alias find='fd'
fi

# Configure lazygit for enhanced git UI
if command -v lazygit &> /dev/null; then
  alias lg='lazygit'
fi

# Configure git aliases
if command -v git &> /dev/null; then
  alias g='git'
  alias ga='git add'
  alias gc='git commit'
  alias gcm='git commit -m'
  alias gp='git push'
  alias gl='git pull'
  alias gb='git branch'
  alias grup='git remote update'
  alias gco='git checkout'
  alias gst='git status'
  alias gsw='git switch'
fi

# Configure nvim aliases
if command -v nvim &> /dev/null; then
  alias vdiff='nvim -d'
  alias vgrep='nvim -p'
  alias vi='nvim'
  alias vim='nvim'
fi

# Configure autosuggestions
if [ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Configure syntax highlighting
if [ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# bun completions
[ -s "/Users/minsikseo/.bun/_bun" ] && source "/Users/minsikseo/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

. "$HOME/.local/bin/env"

# Task Master aliases added on 8/21/2025
alias tm='task-master'
export PATH="/Users/minsikseo/.pixi/bin:$PATH"

# opencode
export PATH=/Users/minsikseo/.opencode/bin:$PATH
