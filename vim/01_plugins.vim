" vim: ft=vim syntax=vim
" vim plugins
" look for more plugins here: http://vimawesome.com/

let s:plugin_dir='~/.cache/vim-plug'

if has('vim_starting')
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
endif

call plug#begin(s:plugin_dir)

  Plug 'Shougo/vimproc.vim', {  'do': 'make'  }
  "Plug 'Shougo/neocomplete.vim'

  Plug 'chriskempson/base16-vim'
  Plug 'scrooloose/nerdcommenter'
  Plug 'w0rp/ale'
  Plug 'itchyny/lightline.vim'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-surround'
  Plug 'luochen1990/rainbow'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-rsi'                " Readline mappings are provided in insert mode and command line mode
  Plug 'tpope/vim-sleuth'             " automatically adjusts 'shiftwidth' and 'expandtab' heuristically based on the current file
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'       " shows a git diff in the 'gutter' (sign column)
  Plug 'MarcWeber/vim-addon-mw-utils' " vim: interpret a file by function and cache file automatically
  Plug 'tomtom/tlib_vim'              " Some utility functions for VIM
  "Plug 'ervandew/supertab'            " Perform all your vim insert mode completions with Tab
  Plug 'maxbrunsfeld/vim-yankstack'   " lightweight implementation of emacs's kill-ring for vim
  Plug 'moll/vim-bbye'                " Delete buffers and close files without closing windows or messing up layout
  Plug 'mhinz/vim-startify'           " A fancy start screen for Vim
  Plug 'sheerun/vim-polyglot'         " Language packs, with syntax, ftplugin, ftdetect, ...

  " pip3 install --user neovim jedi mistune psutil setproctitle
  Plug 'roxma/nvim-completion-manager'
  if !has('nvim')
      Plug 'roxma/vim-hug-neovim-rpc'
  endif

  " Motion/visual
  Plug 'Lokaltog/vim-easymotion'
  Plug 'bkad/CamelCaseMotion'
  Plug 'tommcdo/vim-exchange'
  Plug 'terryma/vim-expand-region'
  Plug 'haya14busa/incsearch.vim'

  " tmux/terminal integration
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'benmills/vimux', {'on':['Vimux']}
  Plug 'kassio/neoterm', {'on':['T']}

  Plug 'tpope/vim-dispatch'
  Plug 'radenling/vim-dispatch-neovim'

  " ./install --all so the interactive script doesn't block
  " you can check the other command line options  in the install file
  Plug 'junegunn/fzf', { 'do': './install --all', 'merged': 0 }
  Plug 'junegunn/fzf.vim', { 'depends': 'fzf' }

  " file managers
  Plug 'ranger/ranger', { 'do': 'make install', 'merged': 0 }
  Plug 'francoiscabrol/ranger.vim', {'on': ['Ranger']}
  Plug 'rbgrouleff/bclose.vim'
  Plug 'justinmk/vim-dirvish', {'on': ['Dirvish']}
  Plug 'scrooloose/nerdtree',
              \ {'on':['NERDTreeToggle', 'NERDTreeFind', 'NERDTree', 'NERDTreeMirrorOpen', 'NERDTreeTabsOpen']}

  Plug 'gregsexton/gitv', {'on': ['Gitv']}              " gitv is a repository viewer similar to gitk. It is an extension of the fugitive git plugin
  Plug 'nathanaelkane/vim-indent-guides', {'on': ['IndentGuides']}
  Plug 'godlygeek/tabular', {'on':['Tabularize']}
  Plug 'junegunn/vim-easy-align',
              \ {'on':['EasyAlign']}
  " nice plugins, but not using it
  "Plug 'jlanzarotta/bufexplorer', {'on':['BufExplorer']}
  "Plug 'majutsushi/tagbar', {'on':['TagbarToggle']}
  "Plug 'junegunn/goyo.vim', {'on':['Goyo']}
  "Plug 'xolox/vim-easytags', {'on':['UpdateTags', 'HighlightTags']}
  " frontend
  "Plug 'yuratomo/w3m.vim', {'on':['W3m', 'W3mTab']}
  "Plug 'othree/xml.vim',
              "\ { 'for' : ['xml', 'html', 'htm', 'haml', 'erb', 'hb', 'jsp', 'hbs'] }
  "Plug 'mattn/emmet-vim',
              "\ { 'for' : ['xml', 'html', 'htm', 'haml', 'erb', 'hb', 'jsp', 'css', 'hbs'] }
  "Plug 'ap/vim-css-color',
              "\ { 'for' : ['css', 'html', 'htm', 'haml', 'erb', 'hbls'] }
  " backend / functional
  "Plug 'tpope/vim-leiningen', { 'for' : [ 'clj' ] }
  "Plug 'tpope/vim-projectionist', { 'for' : [ 'clj' ] }
  "Plug 'tpope/vim-fireplace', { 'for' : [ 'clj' ] }
  Plug 'ensime/ensime-vim', { 'for' : [ 'scala' ] }
  Plug 'derekwyatt/vim-scala', { 'for' : [ 'scala' ] }
  Plug 'megaannum/vimside', { 'for' : [ 'scala' ] }
  "Plug 'fatih/vim-go', { 'for' : [ 'go' ] }
  Plug 'chrisbra/csv.vim', { 'for' : ['csv', 'tsv'] }
  Plug 'plasticboy/vim-markdown', { 'for' : ['markdown', 'md', 'mkd', 'text'] }
  "Plug 'ledger/vim-ledger', { 'for' : ['ledger'] }

call plug#end()
