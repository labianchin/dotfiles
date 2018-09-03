#!/usr/bin/env sh

# exit immediately if something fails
set -o nounset
set -o errexit

readonly DIR="$( cd "$( dirname "$0" )" && pwd )"

# install xcode if needed
xcode-select -p || xcode-select --install
#sudo xcode-select --switch /Library/Developer/CommandLineTools
# xcode-select --reset

#export HOMEBREW_SOURCEFORGE_MIRROR='ufpr'
#export HOMEBREW_SOURCEFORGE_MIRROR='tcpdiag'

if ! hash brew 2> /dev/null; then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

set -o xtrace

brew tap Homebrew/bundle
brew tap caskroom/fonts

# fundamentals
brew install neovim zsh coreutils findutils fzf git tmux hub
brew cask install google-chrome keeweb google-backup-and-sync borgbackup iterm2 hammerspoon font-fira-code

exec brew bundle --verbose --file="$DIR/Brewfile"

