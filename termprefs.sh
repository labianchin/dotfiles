#!/bin/bash

# Bash/ZSH custom configurations

# === Simple custom aliases

alias rsync2="rsync -avz --delete --progress"
alias sshProxySocks="ssh -CNf -D 1234"
alias vdu="vagrant destroy -f && vagrant up"
alias gitsearch='git rev-list --all | xargs git grep -F'
alias v='vim'

# === Tmux aliases
alias tma='tmux attach -d -t'
alias tmn='tmux new -s $(basename $(pwd))'
alias tml='tmux list-sessions'

# === Java aliases
alias java_ls='/usr/libexec/java_home -Vq 2>&1 | grep -E "\d\.\d\.\d(_\d+)?.*," | cut -d , -f 1 | cut -c 5-'
function java_use() {
    export JAVA_HOME=$(/usr/libexec/java_home -v $1)
	java -version
}

# === boot2docker port forwarding
function dfwd {  
  VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port$1,tcp,127.0.0.1,$1,,$1"
}
function ddfwd {  
  VBoxManage modifyvm "boot2docker-vm" --natpf1 delete "tcp-port$1"
}

# === OS Specific config
case `uname -s` in
  Darwin)
	[[ -s "$HOME/gap/gaprc.sh" ]] && source $HOME/gap/gaprc.sh
    alias ls='ls -FG --color=always'
	alias grep="grep --color=always"
	alias egrep="egrep --color=always"
    alias postgres_start_server_on_mac="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
	# Loads z
	. `brew --prefix`/etc/profile.d/z.sh
	alias swap_off="sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.dynamic_pager.plist"
	alias swap_on="sudo launchctl load /System/Library/LaunchDaemons/com.apple.dynamic_pager.plist"
	alias swap_rm="sudo rm /private/var/vm/swapfile*"
	export PATH="/usr/local/bin:$PATH"
	# GNU Coreutils
 	[ -s "/usr/local/opt/coreutils/libexec/gnubin" ] && export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
 	[ -s "/usr/local/opt/coreutils/libexec/gnuman" ] && export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
	    ;;
  Linux)
    alias ls='ls -F --color=auto'
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection clipboard -o'
	~/Dropbox/dev/xcape/xcape -e 'Control_L=Escape'
    ;;
esac

# Load RVM, if available
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Loads SCM breeze, if available
[[ -s "$HOME/.scm_breeze/scm_breeze.sh" ]] && source "$HOME/.scm_breeze/scm_breeze.sh"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR=vim

# set PATH so it includes user's private bin if it exists
[[ -d "$HOME/bin" ]] && PATH="$HOME/bin:$PATH"

# TODO: should this script be broken into multiple files?
