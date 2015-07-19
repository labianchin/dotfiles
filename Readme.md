
My Dotfiles
===========

## What?

These are my dotfiles configuration. It is mostly zsh, vim and tmux. But there are also OS specific configuration. For OSX there is configuration for mjolnir and iTerm2. For Linux (Ubuntu/Mint) there is configuration for xbindkeysrc, xcape and conky.

## Full Install

**Warning:** full install is not recommended as it might overwrite things you don't want. Check the install specifics for tools such vim and tmux.

```
git clone https://github.com/labianchin/dotfiles.git ~/.dotfiles && bash ~/.dotfiles/install.sh
```

## Install only specifics

If you want you can install dotfiles just for specific apps. This is done mostly by doing a symlink of the configuration files.

**Warning:** This will override you configuration files. Please, understand each command and backup your files.

### zsh

I use oh-my-zsh, please follow the instructions here https://github.com/robbyrussell/oh-my-zsh and look for the files zshrc and myterminalrc for my configuration.

### vim

Run the install script, which will backup your config and install the new config:

```
bash ~/.dotfiles/vim/install.sh
```

Or alternatively run this:

```
ln -sf ~/.dotfiles/vim ~/.vim
ln -sf ~/.vim/vimrc.vim ~/.vimrc
vim +BundleInstall +qall
```

If using OS X, install vim 7.4 with brew, it is more complete than the one that come with the system.

```
brew install vim --override-system-vi
```

### tmux

```
ln -sf ~/.dotfiles/tmux.conf ~/.tmux.conf
ln -sf ~/.dotfiles/tmux-osx.conf ~/.tmux-osx.conf
```

### Solarized theme

Install [solarize theme in iterm2](https://github.com/altercation/solarized/tree/master/iterm2-colors-solarized)

### Instal powerline fonts

Install [powerline fonts](https://github.com/Lokaltog/powerline-fonts). I am using SourceCodePro.

## TODO

- Add common bin
- Check https://github.com/MatthewMueller/dots and https://gist.github.com/MatthewMueller/e22d9840f9ea2fee4716
- Put Debian/Ubuntu/Mint specific install and config
- zshrc install custom plugins like this:
  - (cd ~/.oh-my-zsh/custom/plugins && git clone https://github.com/hchbaw/opp.zsh )
- zsh use vi-mode
- take a look here for vi-mode: https://github.com/dougblack/dotfiles/blob/master/.zshrc
- have a way to switch between emacs and vi-mode
- http://usevim.com/2015/03/27/zsh/
