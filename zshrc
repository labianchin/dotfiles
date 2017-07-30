#!/bin/zsh

#zmodload zsh/zprof  # uncoment and run zprof for profiling
SHELL=$(which zsh)

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

dot_sources=(
  '.zplug-setup'
  #'.zgen-setup'  # zgen, DEPRECATED
  '.myterminalrc'  # custom portable bash/zsh/sh config
  '.zshrc.local'  #other portable config
  )
for dot in $dot_sources; do
  [[ -s "$HOME/$dot" ]] && source "$HOME/$dot"
done

# Load fzf autocompletion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

