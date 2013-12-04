# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git ruby osx git-extras sublime svn vagrant)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/opt/local/bin:/opt/local/sbin
export PATH=/usr/local/bin:/opt/local/bin:/opt/local/sbin:$PATH
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

export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8
