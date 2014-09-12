#!/usr/bin/env bash

set -o errexit
set -o nounset

parentdir=$(cd $(dirname "$0")/..; pwd)

echo "== VIM configuration"
echo "=== The vim you have is the following: "
vim --version | head -1

echo "=== Installing vim configuration (vimrc and vim folder from $parentdir)"
ln -sf $parentdir/vimrc ~/.vimrc
ln -sf $parentdir/vim ~/.vim

echo "=== Installing vim plugins (using neobundle)"
vim +NeoBundleInstall +qall
