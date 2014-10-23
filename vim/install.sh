#!/usr/bin/env bash

set -o errexit
set -o nounset

parentdir=$(cd $(dirname "$0")/..; pwd)

echo "== VIM configuration"
echo "=== The vim you have is the following: "
vim --version | head -1

echo "=== Installing vim configuration (vimrc and vim folder from $parentdir)"
mv ~/.vimrc ~/.vim /tmp/
ln -s $parentdir/vim ~/.vim
ln -s ~/.vim/vimrc_dot ~/.vimrc

echo "=== Installing vim plugins (using neobundle)"
vim +NeoBundleInstall +qall
