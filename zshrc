#!/bin/zsh

export TERM="xterm-256color"
#zmodload zsh/zprof  # uncoment and run zprof for profiling
#SHELL=$(which zsh)
DEFAULT_USER=labianchin

#POWERLEVEL9K_MODE='compatible'
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon load context dir virtualenv vcs)
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs rbenv virtualenv history time)

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


declare -A ZINIT
ZINIT[HOME_DIR]="${ZDOTDIR:-$HOME}/.config/zinit"

install_zinit() {
  if [[ ! -d ${ZINIT[HOME_DIR]} ]]; then
    set -x
    mkdir "${ZINIT[HOME_DIR]}"
    chmod g-rwX "${ZINIT[HOME_DIR]}"
    set +x
  fi
  if [[ ! -d ${ZINIT[HOME_DIR]}/bin ]]; then
    echo "Installing zinit..."
    git clone --depth 10 https://github.com/zdharma/zinit.git "${ZINIT[HOME_DIR]}/bin"
  fi
}

setup_zinit() {
  install_zinit
  source "${ZINIT[HOME_DIR]}/bin/zinit.zsh"
  autoload -Uz _zinit
  (( ${+_comps} )) && _comps[zinit]=_zinit

  # https://zdharma.org/zinit/wiki/Example-Minimal-Setup/
  zinit wait lucid light-mode for \
    atinit"zicompinit; zicdreplay" \
    zdharma/fast-syntax-highlighting \
    atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
    blockf atpull'zinit creinstall -q .' \
    zsh-users/zsh-completions \
    OMZ::lib/git.zsh \
    atload"unalias grv" OMZ::plugins/git/git.plugin.zsh

  setopt promptsubst
  # https://zdharma.org/zinit/wiki/For-Syntax/#examples

  #zinit ice wait"0" blockf  #  load 0 seconds (about 150 ms exactly) after prompt,
  #zinit light zsh-users/zsh-completions
  #zinit ice wait"0" atload"_zsh_autosuggest_start"
  #zinit light zsh-users/zsh-autosuggestions
  #zinit ice wait"0" atinit"zpcompinit; zpcdreplay"
  #zinit light zdharma/fast-syntax-highlighting
  #setopt promptsubst
  #zinit ice wait"0" lucid
  #zinit snippet OMZ::lib/git.zsh
  #zinit ice wait"0" atload"unalias grv" lucid
  #zinit snippet OMZ::plugins/git/git.plugin.zsh

  zinit snippet OMZ::lib/key-bindings.zsh
  #zinit snippet OMZ::plugins/docker/_docker
  #zinit ice wait"0"
  #zinit ice atinit'zmodload zsh/zprof' atload'zprof | head; zmodload -u zsh/zprof'
  zinit for \
    light-mode bhilburn/powerlevel9k \
    #light-mode Aloxaf/fzf-tab \

  #zinit snippet "https://github.com/chriskempson/base16-shell/blob/master/scripts/base16-tomorrow-night.sh"

  #zinit self-update
  #zinit update --all
}

load_dotsources() {
  dot_sources=(
    "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
    "$HOME/.myterminalrc"  # custom portable bash/zsh/sh config
    "$HOME/.zshrc.local"  #other portable config
    /usr/local/opt/asdf/asdf.sh  # slow?
    #"$HOME/.fzf/shell/key-bindings.zsh"
  )
  # if interactive shell: https://stackoverflow.com/questions/31155381/what-does-i-mean-in-bash
  [[ $- == *i* ]] && dot_sources+=(
    "/usr/local/opt/fzf/shell/key-bindings.zsh"
    #"/usr/local/opt/fzf/shell/completion.zsh"  # do not want tab completion :/
    #"$HOME/.fzf/shell/completion.zsh"
    #"/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc" # 0.06 sec
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

setup_zinit
load_dotsources
setup_fzf
