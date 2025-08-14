# Load .bashrc if it exists
if [ -f ~/.bashrc ]; then
  source "$HOME/.bashrc"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
. "$HOME/.cargo/env"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/minsikseo/.lmstudio/bin"
# End of LM Studio CLI section

. "$HOME/.local/bin/env"
