#!/usr/bin/env bash

set -o errexit
set -o nounset

readonly CURRENT_DIR=$(cd $(dirname "$0"); pwd)

echo "== VIM configuration"
echo "=== Vim current version is the following (make sure is >=7.4): "
vim --version | head -1

echo "Make sure you have installed the following dependencies:
Powerline fonts: https://github.com/powerline/fonts
Ag silver searcher: https://github.com/ggreer/the_silver_searcher"

readonly TARGET_VIM_DIR="$HOME/.vim"
readonly TARGET_VIMRC="$HOME/.vimrc"

echo "=== Installing vim configuration (vimrc and vim folder from $CURRENT_DIR)"
mv "$TARGET_VIMRC" "$TARGET_VIM_DIR" /tmp/ || true

ln -s "$CURRENT_DIR" "$TARGET_VIM_DIR"
ln -s "$TARGET_VIM_DIR/vimrc.vim" "$TARGET_VIMRC"

echo "=== Installing vim plugins (using neobundle)"
vim +NeoBundleInstall +qall


# TODO: https://github.com/mutewinter/dot_vim
# https://github.com/nathanaelkane/vim-indent-guides
# add NeoVim install