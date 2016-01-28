#!/usr/bin/env bash

set -o errexit
set -o nounset

readonly dir=$(cd $(dirname "$0"); pwd) # dotfiles directory

# list of files/folders to symlink in homedir
files="zshrc zgen-setup myterminalrc ctags gitconfig gitignore_global tmux.conf curlrc"
xfiles="xbindkeysrc conkyrc gtk-bookmarks"

function symlink_files() {
  local source=$1
  local files=$2
  local backup=$3
  # move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
  echo "=== Symlinking all of these dotfiles ==="
  echo "$files"
  echo "=== ==="
  echo "Old files will be placed at $backup folder"
  mkdir -p "$backup"
  for file in $files; do
      mv "$HOME/.$file" "$backup/" || true
      ln -sf "$source/$file" "$HOME/.$file"
  done
}

readonly bkp_dir=~/dotfiles_old       # old dotfiles backup directory
# Install common dotfiles
symlink_files "$dir" "$files" $bkp_dir

# OS specific config
case $(uname -s) in
  Darwin)

    git config --global credential.helper osxkeychain
    ;;
  Linux)
    # has xorg running?
    [[ "$(ps --no-headers -C X)" ]] && symlink_files "$dir/linux" "$xfiles" $bkp_dir
 
    git config --global credential.helper cache
    ;;
esac

echo ""
bash "$dir/vim/install.sh"

echo ""
echo "Adding myterminalrc to bashrc"
grep -Fq 'source ~/.myterminalrc' ~/.bashrc || echo 'source ~/.myterminalrc' >> ~/.bashrc

function zsh-as-default() {
  if grep -Fxq "$(which zsh)" /etc/shells
  then
    echo "ZSH ok"
  else
    echo "Warning: remember to change shell"
    echo "echo \$(which zsh) | sudo tee -a /etc/shells"
    echo "chsh -s \$(which zsh)"
    echo "Remember to logout and login again"
  fi
}

zsh-as-default

function fzf-install() {
  # https://github.com/junegunn/fzf
  [[ ! -d ~/.fzf ]] && git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  [[ ! -f ~/.fzf/bin/fzf ]] && ~/.fzf/install --bin
}

fzf-install

#echo "Making zsh and bash history append only"
#chattr +a ~/.{bash,zsh}_history
#chflags uappnd ~/.{zsh,bash}_history

echo "DONE!"
