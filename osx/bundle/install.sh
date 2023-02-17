#!/usr/bin/env sh

# exit immediately if something fails
set -o nounset
set -o errexit

readonly DIR="$( cd "$( dirname "$0" )" && pwd )"

# install xcode if needed
xcode-select --print-path || xcode-select --install
# xcode-select --version
# https://apple.stackexchange.com/questions/359821/whats-the-best-way-to-update-homebrew-when-upgrading-macos
#softwareupdate --all --install --force
#sudo xcode-select --switch /Library/Developer/CommandLineTools
# xcode-select --reset
# https://apple.stackexchange.com/questions/254380/why-am-i-getting-an-invalid-active-developer-path-when-attempting-to-use-git-a

if ! hash brew 2> /dev/null; then
  echo "Installing Homebrew https://brew.sh/ ..."
  /bin/bash -xc "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

taps() {
  brew tap homebrew/bundle
  brew tap homebrew/cask
  brew tap homebrew/cask-fonts
  brew tap homebrew/cask-versions
}

brew_parallel() {
  echo "$@" | time xargs -n1 -P4 brew fetch || true
  brew install "$@" || true
}

main() {
  set -o xtrace
  export HOMEBREW_NO_ANALYTICS=1
  export HOMEBREW_NO_INSTALL_CLEANUP=1
  #time taps

  # fundamentals
  time brew install neovim zsh coreutils findutils git readline curl bash gnu-sed || true
  export HOMEBREW_NO_AUTO_UPDATE=1

  time brew_parallel \
      google-chrome keepassxc kitty hammerspoon \
      font-fira-code karabiner-elements corretto11 dropbox google-drive \
      curl readline fzf tmux ripgrep coreutils gnu-sed make grep gnu-tar gnu-time gnu-which gnu-indent gnu-units findutils \
      ca-certificates  \
      openssl@1.1 sqlite sqlite3 xz zlib luv libuv glib \
      pkg-config gdbm mpdecimal tcl-tk \
      libyaml python@3 borgbackup pandoc ruby pyenv jq
  time brew_parallel \
    homebrew/cask/docker intellij-idea-ce

  # java tooling (do not install openjdk)
  brew install --ignore-dependencies maven scala sbt || true

  time brew bundle --verbose --file="$DIR/Brewfile"
  brew analytics off
}

main
