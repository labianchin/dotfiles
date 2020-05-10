#!/usr/bin/env sh

# exit immediately if something fails
set -o nounset
set -o errexit

readonly DIR="$( cd "$( dirname "$0" )" && pwd )"

# install xcode if needed
xcode-select --print-path || xcode-select --install
#sudo xcode-select --switch /Library/Developer/CommandLineTools
# xcode-select --reset
# https://apple.stackexchange.com/questions/254380/why-am-i-getting-an-invalid-active-developer-path-when-attempting-to-use-git-a

if ! hash brew 2> /dev/null; then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
brew analytics off

set -o xtrace

brew tap homebrew/bundle
brew tap homebrew/cask-fonts

brew_parallel() {
  echo "$@" | time xargs -n1 -P4 brew fetch
  brew install "$@"
}

brew_cask_parallel() {
  echo "$@" | time xargs -n1 -P4 brew cask fetch
  brew cask install "$@"
}

# fundamentals
time brew install neovim zsh coreutils findutils git readline || true
brew_cask_parallel google-chrome keepassxc google-backup-and-sync kitty borgbackup hammerspoon font-fira-code karabiner-elements corretto corretto8 slack
brew_parallel curl readline fzf tmux rg gnu-sed docker python3 maven emacs sqlite pandoc python@3 ruby libyaml

time brew bundle --verbose --file="$DIR/Brewfile"

