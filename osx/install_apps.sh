#!/bin/bash

# exit immediately if something fails
set -o nounset
set -o errexit

if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

while read -r line; do
  [[ -z "$line" ]] && continue;
  brew $line || true
done <<< "$(grep -v '^$\|^\s*\#' Brewfile)"

exit 0
