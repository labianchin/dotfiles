#!/bin/bash

alias rsync2="rsync -avz --delete --progress"
alias sshProxySocks="ssh -CNf -D 1234"
alias vdu="vagrant destroy -f && vagrant up"

case `uname -s` in
  Darwin)
    alias ls='ls -FG'
    alias gap_create_workspace="cd ~/gap/build/dev/; ./create-unix-workspace.rb"
    alias gap_update_build="pushd ~/gap/build; svn up; popd"
    alias gap_cd="cd ~/gap"
    alias postgres_start_server_on_mac="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
    alias jira="/Users/larmand/Downloads/jira-cli-3.7.0-SNAPSHOT/jira.sh"
    ;;
  Linux)
    alias ls='ls -F --color=auto'
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection clipboard -o'
    ;;
esac
alias gitsearch='git rev-list --all | xargs git grep -F'
alias v='vim'

# Load RVM, if available
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

. `brew --prefix`/etc/profile.d/z.sh

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
