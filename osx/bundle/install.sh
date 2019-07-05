#!/usr/bin/env sh

# exit immediately if something fails
set -o nounset
set -o errexit

readonly DIR="$( cd "$( dirname "$0" )" && pwd )"

# install xcode if needed
xcode-select -p || xcode-select --install
#sudo xcode-select --switch /Library/Developer/CommandLineTools
# xcode-select --reset
# https://apple.stackexchange.com/questions/254380/why-am-i-getting-an-invalid-active-developer-path-when-attempting-to-use-git-a

if ! hash brew 2> /dev/null; then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
brew analytics off

set -o xtrace

brew tap Homebrew/bundle
brew tap caskroom/fonts

# fundamentals
brew install neovim zsh coreutils findutils fzf git tmux hub rg || true
brew cask install google-chrome keeweb google-backup-and-sync || true
borg cask install borgbackup iterm2 hammerspoon font-fira-code kitty karabiner-elements || true

exec brew bundle --verbose --file="$DIR/Brewfile"

