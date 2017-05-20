#!/usr/bin/env bash

# exit immediately if something fails
set -o nounset
set -o errexit

# install xcode if needed
xcode-select -p || xcode-select --install

#export HOMEBREW_SOURCEFORGE_MIRROR='ufpr'
#export HOMEBREW_SOURCEFORGE_MIRROR='tcpdiag'

if ! hash brew 2> /dev/null; then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew tap Homebrew/bundle

readonly dir=$(dirname "$(readlink -f "$0")")

exec brew bundle --verbose --file="$dir/Brewfile"

