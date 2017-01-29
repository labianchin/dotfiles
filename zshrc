#!/bin/zsh

PROFILE_STARTUP=false
if [[ "$PROFILE_STARTUP" == true ]]; then
    # http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
    PS4=$'%D{%M%S%.} %N:%i> '
    exec 3>&2 2>/tmp/startlog.$$
    setopt xtrace prompt_subst
fi
SHELL=$(which zsh)

DEFAULT_USER=labianchin

#POWERLEVEL9K_MODE='compatible'
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon load context dir virtualenv vcs)
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(virtualenv background_jobs status history time)
#POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(longstatus time)

#[[ -s "$HOME/.zgen-setup" ]] && source "$HOME/.zgen-setup"
[[ -s "$HOME/.zplug-setup" ]] && source "$HOME/.zplug-setup"

# Add custom generic shell config
[[ -s "$HOME/.myterminalrc" ]] && source "$HOME/.myterminalrc"

# Load custom zsh config if available
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

# Load fzf autocompletion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Long running processes should return time after they complete. Specified
# in seconds.
REPORTTIME=5
TIMEFMT="%U user %S system %P cpu %*Es total"

# Entirety of my startup file... then
if [[ "$PROFILE_STARTUP" == true ]]; then
    unsetopt xtrace
    exec 2>&3 3>&-
fi


