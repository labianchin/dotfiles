#!/bin/zsh

SHELL=$(which zsh)

DEFAULT_USER=larmand
DISABLE_AUTO_UPDATE="true" # Comment this out to disable bi-weekly auto-update checks
COMPLETION_WAITING_DOTS="true" # red dots to be displayed while waiting for completion

# Load zgen if available
[[ -s "$HOME/.zgen-setup" ]] && source "$HOME/.zgen-setup"

# Add custom generic shell config
[[ -s "$HOME/.myterminalrc" ]] && source "$HOME/.myterminalrc"

# Add fzf if available
[[ -f "$HOME/.fzf.zsh" ]] && source "$HOME/.fzf.zsh"
