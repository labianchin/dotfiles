#!/bin/bash

# Bash/ZSH custom configurations

# Custom aliases

alias rsync2="rsync -avz --delete --progress"
alias sshProxySocks="ssh -CNf -D 1234"
alias vdu="vagrant destroy -f && vagrant up"
alias gitsearch='git rev-list --all | xargs git grep -F'
alias v='vim'

case `uname -s` in
  Darwin)
	[[ -s "$HOME/gap/gaprc.sh" ]] && source $HOME/gap/gaprc.sh
    alias ls='ls -FG'
    alias postgres_start_server_on_mac="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
	# Loads z
	. `brew --prefix`/etc/profile.d/z.sh
    ;;
  Linux)
    alias ls='ls -F --color=auto'
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection clipboard -o'
    ;;
esac

# Load RVM, if available
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# Loads SCM breeze, if available
[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && source "$HOME/.scm_breeze/scm_breeze.sh"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
