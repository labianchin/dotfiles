" Based on:
" https://github.com/mathiasbynens/dotfiles/blob/master/.vimrc
" https://github.com/square/maximum-awesome/blob/master/vimrc
" https://github.com/skwp/dotfiles/blob/master/vimrc
" https://bitbucket.org/sjl/dotfiles/src/141b96496989091fce4aa5165946f94d31c2374f/vim/vimrc?at=default
" https://github.com/Shougo/shougo-s-github/blob/master/vim/vimrc

" Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

" Make Vim more useful
set nocompatible

let g:mapleader = ' '

" Load vim files
" Only files with underline in the middle
runtime! *_*.vim

" Use local vimrc if available
if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif