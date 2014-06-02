
My Dotfiles
===========

## What?

These are my dotfiles configuration. It is mostly zsh, vim and tmux. But there are also OS specific configuration. In OSX I use slate and iTerm2. In Linux I use gvim, xbindkeysrc, xcape and conky.

## Install

```
git clone https://github.com/labianchin/dotfiles.git ~/dotfiles && bash ~/dotfiles/install.sh
```

## Install only specifics

If you want you can install dotfiles just for specific apps. This is done mostly by doing a symlink of the configuration files.

### vim

```
ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/vim ~/.vim
vim +BundleInstall +qall
```

### tmux

```
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/tmux-osx.conf ~/.tmux-osx.conf
vim +BundleInstall +qall
```

## TODO

- Put common binaries
- Configure install for common tools (zsh, tmux, vim, ack, ag, ...)
