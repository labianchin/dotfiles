#!/usr/bin/env bash

set -o errexit
set -o nounset

readonly CURRENT_DIR=$(cd $(dirname "$0"); pwd)

echo "== VIM configuration"
echo "=== Vim current version is the following (make sure is >=7.4): "
vim --version | head -1

command -v nvim >/dev/null 2>&1 && alias vim='nvim' && (nvim --version | head -1)

echo "Make sure you have installed the following dependencies:
Powerline fonts: https://github.com/powerline/fonts
Ag silver searcher: https://github.com/ggreer/the_silver_searcher"

readonly TARGET_VIM="$HOME/.vim"
readonly TARGET_NVIM="$HOME/.config/nvim"

mkdir -p "$HOME/.config/"
echo "=== Installing vim/nvim configuration (vimrc and vim folder from $CURRENT_DIR)"
mv "${TARGET_VIM}rc" "$TARGET_VIM" "$TARGET_NVIM" /tmp/ || true

ln -sf "$CURRENT_DIR" "$TARGET_VIM"
ln -sf "$TARGET_VIM/init.vim" "${TARGET_VIM}rc"

ln -sf "$CURRENT_DIR" "$TARGET_NVIM"

echo "=== Installing vim plugins"
#vim +NeoBundleInstall +qall
vim -c '+call dein#update()' +qall


# TODO: https://github.com/mutewinter/dot_vim
# https://github.com/nathanaelkane/vim-indent-guides
# add NeoVim install