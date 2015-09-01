#!/bin/bash

# exit immediately if something fails
set -o nounset
set -o errexit

# install xcode if needed
xcode-select -p || xcode-select --install

#export HOMEBREW_SOURCEFORGE_MIRROR='ufpr'
export HOMEBREW_SOURCEFORGE_MIRROR='tcpdiag'

if ! hash brew 2> /dev/null; then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

while read -r line; do
  [[ -z "$line" ]] && continue;
  echo '~> Running `brew $line`'
  brew $line || true
done <<< "$(grep -v '^$\|^\s*\#' Brewfile)"

exit 0
