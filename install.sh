#!/usr/bin/env bash
# Ideas on how to install stuff: https://news.ycombinator.com/item?id=11938009

set -o errexit
set -o nounset

readonly dir=$(cd $(dirname "$0"); pwd) # dotfiles directory

# list of files/folders to symlink in homedir
readonly sfiles="zshrc zgen-setup myterminalrc ctags gitconfig gitignore_global tmux.conf curlrc tmux spacemacs"
readonly xfiles="xbindkeysrc conkyrc gtk-bookmarks"
readonly osxfiles="kwm hammerspoon"

# backup and symlink a single file
function backup_symlink() {
  local from=$1
  local to=$2
  local backup=$3
  mv "$to" "$backup/" || true
  ln -sf "$from" "$to"
}

function symlink_files() {
  local source=$1
  local files=$2
  local backup=$3
  echo "=== Symlinking all of these dotfiles ==="
  echo "$files"
  echo "Old files will be placed at $backup folder"
  mkdir -p "$backup"
  for file in $files; do
    backup_symlink "$source/$file" "$HOME/.$file" "$backup"
  done
}

function install-dots() {
  readonly bkp_dir=~/dotfiles_old       # old dotfiles backup directory
  # Install common dotfiles
  symlink_files "$dir" "$sfiles" $bkp_dir
  backup_symlink "$dir/ssh_config" "$HOME/.ssh/config" $bkp_dir

  # OS specific config
  case $(uname -s) in
    Darwin)

      git config --global credential.helper osxkeychain
      symlink_files "$dir/osx" "$osxfiles" $bkp_dir
      ;;
    Linux)
      # has xorg running?
      [[ "$(ps --no-headers -C X)" ]] && symlink_files "$dir/linux" "$xfiles" $bkp_dir
  
      git config --global credential.helper cache
      ;;
  esac

  echo "These are the symlinks in $HOME"
  #find "$HOME" -maxdepth 2 -type l -exec ls -lh {} + 2>/dev/null
  find "$HOME" -maxdepth 2 -type l -exec ls -lah --color {} + 2>/dev/null
  #find . -maxdepth 1 -exec readlink {} +
  # TODO: better format this ls!
}

function myterminalrc-bashrc() {
  echo ""
  echo "Adding myterminalrc to bashrc"
  grep -Fq 'source ~/.myterminalrc' ~/.bashrc || echo 'source ~/.myterminalrc' >> ~/.bashrc
}

function vim-install() {
  echo ""
  bash "$dir/vim/install.sh"
}

function spacemacs-install() {
  [[ ! -d ~/.emacs.d ]] && git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
  echo "emacs installed, config is placed on ~/.spacemacs"
}

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

function fzf-install() {
  # https://github.com/junegunn/fzf
  [[ ! -d ~/.fzf ]] && git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  [[ ! -f ~/.fzf/bin/fzf ]] && ~/.fzf/install --all
  # --all generates the ~/.fzf.zsh
}

#echo "Making zsh and bash history append only"
#chattr +a ~/.{bash,zsh}_history
#chflags uappnd ~/.{zsh,bash}_history

function main() {
  install-dots
  myterminalrc-bashrc
  vim-install
  #spacemacs-install
  zsh-as-default
  fzf-install
  echo "DONE!"
}

main
