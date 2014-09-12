
My Dotfiles
===========

## What?

These are my dotfiles configuration. It is mostly zsh, vim and tmux. But there are also OS specific configuration. In OSX I use slate and iTerm2. In Linux I use gvim, xbindkeysrc, xcape and conky.

## Install

Warning: avoid doing this, it might overwrite things you don't want

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

If using OS X, install vim 7.4 with brew, it is more complete than the one that come with the system.

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

- Add common bin
- Configure install (brew/apt-get) for common tools (zsh, tmux, vim, ack, ag, ...)
- Vim NerdTree should focus on open file
- System yank for vim does not seem to be working inside tmux

