#!/usr/bin/env bash

# exit immediately if something fails
set -o nounset
set -o errexit

readonly DIR="$( cd "$( dirname "$0" )" && pwd )"

# install xcode if needed
xcode-select -p || xcode-select --install

#export HOMEBREW_SOURCEFORGE_MIRROR='ufpr'
#export HOMEBREW_SOURCEFORGE_MIRROR='tcpdiag'

if ! hash brew 2> /dev/null; then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

set -o xtrace

brew tap Homebrew/bundle

exec brew bundle --verbose --file="$DIR/Brewfile"

