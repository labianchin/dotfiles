#!/usr/bin/env bash
# Ideas on how to install stuff: https://news.ycombinator.com/item?id=11938009

set -o errexit
set -o nounset

readonly DIR=$(dirname "$(readlink -f "$0")")

is_osx() {
    [[ $('uname') == 'Darwin' ]]
}

is_linux() {
    [[ $('uname') == 'Linux' ]]
}

is_xorg_running() {
  [[ "$(pidof X)" ]]
}

is_termux() {
    [[ "$(command -v termux-info >/dev/null 2>&1 && termux-info version)" ]]
}

# store old dotfiles in a backup directory
readonly BACKUP_DIR=${BACKUP_DIR:-$HOME/dotfiles_old}

# backup and symlink a single file
backup_symlink() {
  local from=$1
  local to=$2
  local backup=$3
  mv "$to" "$backup/" || true
  ln -sf "$from" "$to"
}

symlink_files() {
  local source=$1
  local files=$2
  echo "=== Symlinking all of these dotfiles ==="
  echo "$files"
  mkdir -p "$BACKUP_DIR"
  echo "Old files will be placed at $BACKUP_DIR folder"
  for file in $files; do
    backup_symlink "$source/$file" "$HOME/.$file" "$BACKUP_DIR"
  done
}

install_osx_dots() {
  local osxfiles="kwm hammerspoon"
  git config --global credential.helper osxkeychain
  symlink_files "$DIR/osx" "$osxfiles"
}

install_linux_dots() {
  local xfiles="xbindkeysrc conkyrc gtk-bookmarks"
  is_xorg_running && symlink_files "$DIR/linux" "$xfiles"
  git config --global credential.helper cache
}

install_dots() {
  # Install common dotfiles
  local sfiles="zshrc zplug-setup myterminalrc ctags gitconfig gitignore_global tmux.conf curlrc psqlrc spacemacs.d"
  symlink_files "$DIR" "$sfiles"
  backup_symlink "$DIR/ssh_config" "$HOME/.ssh/config" "$BACKUP_DIR"

  is_osx && install_osx_dots
  is_linux && install_linux_dots

  echo "These are the symlinks in $HOME"
  find "$HOME" -maxdepth 2 -type l -exec ls -lah --color {} + 2>/dev/null | sed -e 's/.* \(.* -> .*\)/\1/' -e "/.*dotfiles_old.*->/ d"
  #find . -maxdepth 1 -exec readlink {} +
}

myterminal_bashrc() {
  echo ""
  echo "Adding myterminalrc to bashrc"
  grep -Fq 'source ~/.myterminalrc' ~/.bashrc || echo 'source ~/.myterminalrc' >> ~/.bashrc
}

zsh_as_default() {
  if grep -Fxq "$(which zsh)" /etc/shells; then
    echo "ZSH ok"
  else
    echo "Warning: remember to change shell"
    echo "echo \$(which zsh) | sudo tee -a /etc/shells"
    echo "chsh -s \$(which zsh)"
    chsh -s "$(which zsh)"
    echo "Remember to logout and login again"
  fi
  #echo "Making zsh and bash history append only"
  #chattr +a ~/.{bash,zsh}_history
  #chflags uappnd ~/.{zsh,bash}_history
}

install_vim() {
  echo ""
  sh "$DIR/vim/install.sh"
}

install_spacemacs() {
  [[ ! -d ~/.emacs.d ]] && git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
  git -C ~/.emacs.d pull origin master
  echo "emacs installed and updated, config is placed on ~/.spacemacs"
}

install_fzf_home() {
  [[ ! -d ~/.fzf ]] && git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  git -C ~/.fzf pull origin master
  ~/.fzf/install --all # --all generates the ~/.fzf.zsh
}

install_fzf() {
  [[ -f $(brew --prefix fzf 2>/dev/null) ]] && $(brew --prefix fzf)/install --all || install_fzf_home
}

install_tmux_tpm() {
  tmux -V
  mkdir -p ~/.tmux/plugins
  [[ ! -d ~/.tmux/plugins/tpm ]] && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  is_termux && find "$HOME/.tmux" -type f -executable -exec termux-fix-shebang {} \;
  tmux source-file "$HOME/.tmux.conf"
  bash "$HOME/.tmux/plugins/tpm/bin/install_plugins"
  bash "$HOME/.tmux/plugins/tpm/bin/update_plugins" all
  bash "$HOME/.tmux/plugins/tpm/bin/clean_plugins"
  is_termux && find "$HOME/.tmux" -type f -executable -exec termux-fix-shebang {} \;
}

termux_install() {
  apt install openssh coreutils tmux neovim git curl zsh fzf \
    tar less grep ncurses-utils silversearcher-ag bash jq tig findutils sed ncdu python dnsutils
}

osx_install() {
  bash "$DIR/osx/bundle/install.sh" || true
  bash "$DIR/osx/karabiner-import.sh"
  bash "$DIR/osx/osx-for-hackers.sh"
  # look at
  # https://github.com/thoughtbot/laptop/blob/master/mac
}

intellij(){
  cat << EOF > ~/Library/Preferences/IdeaIC2017.1/idea.vmoptions
-Xms256m
-Xmx1536m
-XX:MaxPermSize=350m
-XX:ReservedCodeCacheSize=64m
-XX:+UseCodeCacheFlushing
-XX:+UseCompressedOops
)
EOF

mkdir -p ~/.sbt/0.13/plugins/
cat << EOF > ~/.sbt/0.13/plugins/plugins.sbt
addSbtPlugin("net.virtual-void" % "sbt-dependency-graph" % "0.8.2")
EOF
}

install_defaults() {
  install_dots
  myterminal_bashrc
  zsh_as_default
  install_tmux_tpm
  install_vim
  #install_spacemacs
  #install_fzf  # managed by zplug or brew
  #is_osx && osx-install
  #TODO base16 install
}

main() {
  if [[ $# -gt 0 ]]; then
    "$@"
  else
    install_defaults
  fi
  echo "DONE!"
}

time main "$@"
