#!/bin/env zsh

export TERM="xterm-256color"
echo -e "$(uname -srp) | ZSH ${ZSH_VERSION} | TERM=$TERM"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#zmodload zsh/zprof  # uncoment and run zprof for profiling
#SHELL=$(which zsh)

setopt auto_cd              # if a command is issued that can't be executed as a normal command,
                            # and the command is the name of a directory, perform the cd command to that directory
setopt auto_pushd           # make cd push the old directory onto the directory stack.
setopt pushd_ignore_dups    # don't push the same dir twice.
setopt extended_glob        # in order to use #, ~ and ^ for filename generation
                            # grep word *~(*.gz|*.bz|*.bz2|*.zip|*.Z) ->
                            # -> searches for word not in compressed files
                            # don't forget to quote '^', '~' and '#'!
setopt longlistjobs         # display PID when suspending processes as well
setopt notify               # report the status of backgrounds jobs immediately
setopt hash_list_all        # Whenever a command completion is attempted, make sure \
                            # the entire command path is hashed first.
setopt completeinword       # not just at the end
setopt nohup                # and don't kill them, either
setopt nonomatch            # try to avoid the 'zsh: no matches found...'
setopt nobeep               # avoid "beep"ing
setopt noglobdots           # * shouldn't match dotfiles. ever.
setopt noshwordsplit        # use zsh style word splitting
setopt interactivecomments  # bash style comments

# https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/history.zsh#L29
## History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000000
SAVEHIST=10000000

## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data
setopt EXTENDED_HISTORY       # Save each command’s beginning timestamp (in seconds since the epoch) and the duration (in seconds) to the history file.
# Lists the ten most used commands.
alias history-stat="history -50000000 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"

setup_zim() {
  typeset -gx ZIM_HOME=~/.zim
  if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
    set -o xtrace
    echo "%F{33}▓▒░ %F{220}Installing zim...%f"
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
    compaudit | xargs chown -R "$(whoami)" "$ZIM_HOME"
    compaudit | xargs chmod -R go-w "$ZIM_HOME"
    set +o xtrace
  fi
  # Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
  if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
    source ${ZIM_HOME}/zimfw.zsh init -q
  fi
  source ${ZIM_HOME}/init.zsh
  # check ./zimrc
  setopt promptsubst
}

load_dotsources() {
  dot_sources=(
    "$HOME/.myterminalrc"  # custom portable bash/zsh/sh config
    "$HOME/.zshrc.local"  #other portable config
    "$HOME/.p10k.zsh"
    "/usr/local/opt/fzf/shell/key-bindings.zsh"
    #/usr/local/opt/asdf/asdf.sh  # slow?
    #"$HOME/.fzf/shell/key-bindings.zsh"
  )
  for dot in $dot_sources; do
    [[ -s "$dot" ]] && source "$dot"
  done
}

# Setup pyenv and pyenv-virtualenv
#if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
#if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

# https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fzf-down() {
  fzf --height 50% "$@" --border
}

gt() {
  # "Nothing to see here, move along"
  is_in_git_repo || return

  # Pass the list of the tags to fzf-tmux
  # - "{}" in preview option is the placeholder for the highlighted entry
  # - Preview window can display ANSI colors, so we enable --color=always
  # - We can terminate `git show` once we have $LINES lines
  git tag --sort -version:refname |
    fzf-tmux --multi --preview-window right:70% \
             --preview 'git show --color=always {} | head -'$LINES
}

_gb() {
  is_in_git_repo || return
  git branch -a --color=always --sort=committerdate -vv | grep -v '/HEAD\s' |
  fzf-down --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

bind-git-helper() {
  local c
  for c in $@; do
    eval "fzf-g$c-widget() { local result=\$(_g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fzf-g$c-widget"
    eval "bindkey '^g^$c' fzf-g$c-widget"
  done
}

setup_fzf() {
  export FZF_COMPLETION_TRIGGER=''
  # https://github.com/junegunn/fzf/wiki/Configuring-fuzzy-completion#dedicated-completion-key
  #bindkey '^T' fzf-completion
  #bindkey '^I' $fzf_default_completion
  bind-git-helper f b t r h
  unset -f bind-git-helper
}

setup_zim
load_dotsources
setup_fzf
