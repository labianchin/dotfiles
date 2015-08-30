#!/bin/zsh

PROFILE_STARTUP=false
if [[ "$PROFILE_STARTUP" == true ]]; then
    # http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
    PS4=$'%D{%M%S%.} %N:%i> '
    exec 3>&2 2>$HOME/tmp/startlog.$$
    setopt xtrace prompt_subst
fi
SHELL=$(which zsh)

DEFAULT_USER=larmand
DISABLE_AUTO_UPDATE="true" # Comment this out to disable bi-weekly auto-update checks
COMPLETION_WAITING_DOTS="true" # red dots to be displayed while waiting for completion

ENHANCD_FILTER="fzf"

# Load zgen if available
[[ -s "$HOME/.zgen-setup" ]] && source "$HOME/.zgen-setup"

# Add custom generic shell config
[[ -s "$HOME/.myterminalrc" ]] && source "$HOME/.myterminalrc"

# Load custom zsh config if available
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

export FZF_DEFAULT_COMMAND='ag -l -g ""'
export FZF_DEFAULT_OPTS="--extended --cycle"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# Add fzf if available
[[ -f "$HOME/.fzf.zsh" ]] && source "$HOME/.fzf.zsh"

# Long running processes should return time after they complete. Specified
# in seconds.
REPORTTIME=5
TIMEFMT="%U user %S system %P cpu %*Es total"

# Entirety of my startup file... then
if [[ "$PROFILE_STARTUP" == true ]]; then
    unsetopt xtrace
    exec 2>&3 3>&-
fi
