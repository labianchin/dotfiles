#!/usr/bin/env bash

set -o errexit
set -o nounset

readonly CURRENT_DIR=$(dirname "$(readlink -f "$0")")

check_version() {
  echo "== VIM/NeoVim configuration"
  if command -v nvim >/dev/null 2>&1; then
    VIMCMD="nvim"
    VIMFLAGS=" --headless"
    echo "=== NeoVim detected "
    echo "=== NeoVim current version is the following: "
  else
    VIMCMD=vim
    VIMFLAGS=""
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
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  rm ~/.local/share/nvim/site/autoload/plug.vim || true
  ln -sf ~/.vim/autoload/plug.vim ~/.local/share/nvim/site/autoload/plug.vim
  time \
    $VIMCMD -u ~/.vim/01_plugins.vim \
    -c '+verbose' '+PlugUpdate' '+PlugClean' '+messages' +qall \
    foo_file || true
  # https://stackoverflow.com/questions/12213597/how-to-see-which-plugins-are-making-vim-slow
  $VIMCMD$VIMFLAGS --cmd 'profile start profile.log' \
    --cmd 'profile func *' \
    --cmd 'profile file *' \
    -c 'profdel func *' \
    -c 'profdel file *' \
    -c 'qa!'
}

main() {
  check_version
  symlink_config
  install_plugins
}

main "$@"
