#!/usr/bin/env bash

set -o errexit
set -o nounset

readonly CURRENT_DIR=$(dirname "$(readlink -f "$0")")

check_version() {
  echo "== VIM/NeoVim configuration"
  if command -v nvim >/dev/null 2>&1; then
    VIMCMD="nvim --headless"
    echo "=== NeoVim detected "
    echo "=== NeoVim current version is the following: "
  else
    VIMCMD=vim
    echo "=== Vim current version is the following (make sure is >=7.4): "
  fi
  $VIMCMD --version | head -1
}

symlink_config() {
  echo "The following tools are also recommended:
  Powerline fonts: https://github.com/powerline/fonts
  Ag silver searcher: https://github.com/ggreer/the_silver_searcher"

  readonly TARGET_VIM="$HOME/.vim"
  readonly TARGET_NVIM="$HOME/.config/nvim"

  mkdir -p "$HOME/.config/"
  echo "=== Installing vim/nvim configuration (vimrc and vim folder from $CURRENT_DIR)"
  mv "${TARGET_VIM}rc" "$TARGET_VIM" "$HOME/.ideavimrc" "$TARGET_NVIM" /tmp/ || true

  ln -sf "$CURRENT_DIR" "$TARGET_VIM"
  ln -sf "$TARGET_VIM/init.vim" "${TARGET_VIM}rc"
  ln -sf "$CURRENT_DIR/ideavimrc" "$HOME/.ideavimrc"

  ln -sf "$CURRENT_DIR" "$TARGET_NVIM"
}

install_plugins() {
  echo "=== Installing vim plugins..."
  $VIMCMD -u ~/.vim/01_plugins.vim -E '+call dein#update()' '+call dein#get_log()' '+messages' +qall || true
  $VIMCMD --startuptime -c +qall /tmp/timeCost.txt /tmp/timeCost.txt
}

main() {
  check_version
  symlink_config
  install_plugins
}

main "$@"
