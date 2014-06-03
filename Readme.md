
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

**Warning:** This will override you configuration files. Please, understand each command and backup your files.

### vim

```
ln -sf ~/dotfiles/vimrc ~/.vimrc
ln -sf ~/dotfiles/vim ~/.vim
vim +BundleInstall +qall
```

If using OS X, install vim with brew, it is more complete than the one that come with the system.

```
brew install vim --override-system-vi
```

### tmux

```
ln -sf ~/dotfiles/tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/tmux-osx.conf ~/.tmux-osx.conf
```

### Solarized theme

Install [solarize theme in iterm2](https://github.com/altercation/solarized/tree/master/iterm2-colors-solarized)

### Instal powerline fonts

Install [powerline fonts](https://github.com/Lokaltog/powerline-fonts). I am using SourceCodePro.

## TODO

- Put common binaries
- Configure install for common tools (zsh, tmux, vim, ack, ag, ...)
