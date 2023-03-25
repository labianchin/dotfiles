#!/usr/bin/env bash

set -o errexit
set -o nounset

readonly DIR="$( cd "$( dirname "$0" )" && pwd )"
export XDG_CONFIG_HOME="$HOME/.nvchadconfig"

check_version() {
  echo "== VIM/NeoVim configuration"
  if command -v nvim >/dev/null 2>&1; then
    echo "=== NeoVim detected "
    echo "=== NeoVim current version is the following: "
  else
    echo "missing nvim"
    exit 99
  fi
  which nvim
  nvim --version
}

install() {
  if [ ! -d "$XDG_CONFIG_HOME" ]; then
    git clone https://github.com/NvChad/NvChad "$XDG_CONFIG_HOME"/nvim --depth 1
  fi
  ln -sf "$DIR" "$XDG_CONFIG_HOME/nvim/lua/custom"

  echo "=== Installing nvim plugins..."
  time \
    nvim \
    --headless \
    +verbose \
    "+Lazy! sync" \
    +'NvChadUpdate' \
    +'Lazy install' \
    +'Lazy clean' \
    +'Lazy clear' \
    +'Lazy health' \
    +'TSUpdate' \
    +'qall!' \
    foo_file || true
}

check() {
  nvim --headless \
    -c 'verbose python3 import platform;print("Python3 v" + platform.python_version())' \
    -c 'qa!'
  # https://stackoverflow.com/questions/12213597/how-to-see-which-plugins-are-making-vim-slow
  # python <(curl -sSL https://raw.githubusercontent.com/hyiltiz/vim-plugins-profile/master/vim-plugins-profile.py) nvim
  nvim --headless --cmd 'profile start /tmp/profile.log' \
    --cmd 'profile func *' \
    --cmd 'profile file *' \
    -c 'profdel func *' \
    -c 'profdel file *' \
    -c 'profile pause *' \
    -c 'qa!'
}

perf1() {
  hyperfine --warmup 3 "nvim -c qa!" || true
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
    install
    perf1
    check
  fi
}

time main "$@"
