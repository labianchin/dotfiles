#!/usr/bin/env bash

set -o errexit
set -o nounset

readonly DIR="$( cd "$( dirname "$0" )" && pwd )"

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
  which "$VIMCMD"
  $VIMCMD --version | head -1
}

symlink_config() {
  echo "The following tools are also recommended:
  Ripgrep: https://github.com/BurntSushi/ripgrep
  "

  readonly TARGET_VIM="$HOME/.vim"
  readonly TARGET_NVIM="$HOME/.config/nvim"

  mkdir -p "$HOME/.config/"
  echo "=== Installing vim/nvim configuration (vimrc and vim folder from $DIR)"
  mv "${TARGET_VIM}rc" "$TARGET_VIM" "$HOME/.ideavimrc" "$TARGET_NVIM" /tmp/ || true

  ln -sf "$DIR" "$TARGET_VIM"
  ln -sf "$TARGET_VIM/init.vim" "${TARGET_VIM}rc"
  ln -sf "$DIR/ideavimrc" "$HOME/.ideavimrc"
  ln -sf "$DIR" "$TARGET_NVIM"
}

install_plugins() {
  echo "=== Installing vim plugins..."
  if [ ! -s ~/.local/share/nvim/site/autoload/plug.vim ]; then
    mkdir -p ~/.local/share/nvim/site/autoload
    mkdir -p ~/.vim/autoload
    mkdir -p ~/.cache/vim-plug
    curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    ln -sf "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim ~/.vim/autoload/plug.vim
  fi
    #+'CocInstall coc-json coc-python coc-snippets coc-vimlsp' \
  time \
    $VIMCMD -e \
    +verbose \
    +'PlugUpgrade' \
    +'PlugUpdate --sync' \
    +'PlugClean!' \
    +'TSUpdate' \
    +'qall!' \
    foo_file || true
}

install_extensions() {
  (
    export PATH=/usr/local/bin:$PATH
    python3 --version  # Favor brew python if available
    python3 -m virtualenv --version || python3 -m pip install virtualenv
    python3 -m virtualenv "$HOME/.cache/vim/py3nvim"
  )
  "$HOME/.cache/vim/py3nvim"/bin/python -m pip install \
    "pynvim>=0.4.3" \
    "websocket-client>=1.2.1" "sexpdata>=0.0.3" "PyYAML>=6.0.0" "pyflakes>=2.2.0" "proselint>=0.12.0" "yamllint>=1.26.3" \
    "mistune>=0.8.4" "psutil>=5.8.0" "setproctitle>=1.2.2" \
    "python-language-server>=0.36.2" "python-language-server[all]>=0.36.2"
  # https://github.com/ncm2/ncm2#requirements
}

check() {
  $VIMCMD -e \
    -c 'verbose python3 import platform;print("Python3 v" + platform.python_version())' \
    -c 'qa!'
  # https://stackoverflow.com/questions/12213597/how-to-see-which-plugins-are-making-vim-slow
  # python <(curl -sSL https://raw.githubusercontent.com/hyiltiz/vim-plugins-profile/master/vim-plugins-profile.py) nvim
  $VIMCMD$VIMFLAGS --cmd 'profile start /tmp/profile.log' \
    --cmd 'profile func *' \
    --cmd 'profile file *' \
    -c 'profdel func *' \
    -c 'profdel file *' \
    -c 'profile pause *' \
    -c 'qa!'
  hyperfine --warmup 3 "$VIMCMD -u NONE -c qa!" || true
  hyperfine --warmup 3 "$VIMCMD -c qa!" || true
}

perf() {
  hyperfine --warmup 3 "nvim -c qa!" || true
  hyperfine --warmup 3 "nvim -u NONE -c qa" || true
  hyperfine --warmup 3 "/usr/bin/vim -u NONE -c qa" || true
  hyperfine --warmup 3 "/usr/bin/vim -c qa" || true
}

main() {
  check_version
  if [[ $# -gt 0 ]]; then
    "$@"
  else
    symlink_config
    install_extensions
    install_plugins
    check
  fi
}

time main "$@"
