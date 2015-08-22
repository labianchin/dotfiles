# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# Use robbyrussell as default theme
ZSH_THEME="robbyrussell"

# Uses agnoter modified when available
#[[ -f "$ZSH/themes/agnoster2.zsh-theme" ]] && ZSH_THEME="agnoster2"
[[ -f "$ZSH/themes/agnoster.zsh-theme" ]] && ZSH_THEME="agnoster"
#ZSH_THEME="ys"
DEFAULT_USER=larmand

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git osx git-extras ruby bundler catimg svn vagrant docker tmuxinator brew jsontools fasd zsh-syntax-highlighting )
#vi-mode opp

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
[[ -s "$HOME/.myterminalrc" ]] && source $HOME/.myterminalrc

set_terminal_tab_title() {
	print -Pn "\e]1;$1:q\a"
}

indicate_tmux_session_in_terminal() {
	[[ -n "$TMUX" ]] && set_terminal_tab_title "$(tmux display-message -p '#S')"
}

precmd_functions=($precmd_functions indicate_tmux_session_in_terminal)

SHELL=$(which zsh)

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
