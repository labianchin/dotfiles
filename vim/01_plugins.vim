" vim: ft=vim syntax=vim
" vim plugins
" look for more plugins here: http://vimawesome.com/
" or https://github.com/bling/dotvim/blob/master/vimrc

if &compatible
  set nocompatible
endif

let s:plugin_dir='~/.cache/dein'
let s:dein_dir=s:plugin_dir . '/repos/github.com/Shougo/dein.vim/'

if has('vim_starting')
  if !filereadable(expand(s:dein_dir . 'README.md'))
    echo "Installing dein into " . s:dein_dir . " ..."
    echom system('git clone --depth 10 https://github.com/Shougo/dein.vim ' . expand(s:dein_dir))
  endif

  execute 'set runtimepath+=' . s:dein_dir
endif

let g:dein#types#git#clone_depth=1

if dein#load_state(s:plugin_dir)
  call dein#begin(s:plugin_dir)
  call dein#add(s:dein_dir)
  call dein#add('Shougo/vimproc.vim', {
      \ 'build': {
      \     'windows': 'tools\\update-dll-mingw',
      \     'cygwin': 'make -f make_cygwin.mak',
      \     'mac': 'make -f make_mac.mak',
      \     'linux': 'make',
      \     'unix': 'gmake',
      \    },
      \ })
  call dein#add('Shougo/neocomplete.vim')


  call dein#add('chriskempson/base16-vim')
  call dein#add('scrooloose/nerdcommenter')
  call dein#add('neomake/neomake')
  call dein#add('vim-airline/vim-airline')
  call dein#add('tpope/vim-sensible')
  call dein#add('tpope/vim-unimpaired')
  call dein#add('tpope/vim-surround')
  call dein#add('luochen1990/rainbow')
  call dein#add('tpope/vim-repeat')
  call dein#add('tpope/vim-rsi')
  call dein#add('tpope/vim-sleuth')
  call dein#add('tpope/vim-fugitive')
  call dein#add('gregsexton/gitv')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('MarcWeber/vim-addon-mw-utils') " vim: interpret a file by function and cache file automatically
  call dein#add('tomtom/tlib_vim')              " Some utility functions for VIM
  call dein#add('ervandew/supertab')            " Perform all your vim insert mode completions with Tab
  call dein#add('maxbrunsfeld/vim-yankstack')   " lightweight implementation of emacs's kill-ring for vim
  call dein#add('moll/vim-bbye')                " Delete buffers and close files without closing windows or messing up layout
  call dein#add('mhinz/vim-startify')           " A fancy start screen for Vim
  call dein#add('sheerun/vim-polyglot')         " Language packs, with syntax, ftplugin, ftdetect, ...
  call dein#add('vim-airline/vim-airline-themes')

  " Motion/visual
  call dein#add('Lokaltog/vim-easymotion')
  call dein#add('bkad/CamelCaseMotion')
  call dein#add('tommcdo/vim-exchange')
  call dein#add('terryma/vim-expand-region')
  call dein#add('nathanaelkane/vim-indent-guides')

  " Tmux integration
  call dein#add('christoomey/vim-tmux-navigator')
  call dein#add('benmills/vimux',
              \ {'on_cmd':['Vimux*']})

  call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
  call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })

  call dein#add('scrooloose/nerdtree',
              \ {'on_cmd':['NERDTreeToggle', 'NERDTreeFind', 'NERDTree', 'NERDTreeMirrorOpen', 'NERDTreeTabsOpen']})
  call dein#add('godlygeek/tabular',
              \ {'on_cmd':['Tabularize']})
  call dein#add('majutsushi/tagbar',
              \ {'on_cmd':['TagbarToggle']})
  call dein#add('jlanzarotta/bufexplorer',
              \ {'on_cmd':['BufExplorer']})
  call dein#add('junegunn/goyo.vim',
              \ {'on_cmd':['Goyo']})
  call dein#add('junegunn/vim-easy-align',
              \ {'on_cmd':['EasyAlign']})
  call dein#add('xolox/vim-easytags',
              \ {'on_cmd':['UpdateTags', 'HighlightTags']})
  call dein#add('yuratomo/w3m.vim',
              \ {'on_cmd':['W3m', 'W3mTab']})
  "call dein#add('garbas/vim-snipmate',
              "\  {'insert': 1})
  "call dein#add('honza/vim-snippets',
              "\  {'insert': 1})
  "filetypes
  call dein#add('othree/xml.vim',
              \ { 'on_ft' : ['xml', 'html', 'htm', 'haml', 'erb', 'hb', 'jsp', 'hbs'] })
  call dein#add('mattn/emmet-vim',
              \ { 'on_ft' : ['xml', 'html', 'htm', 'haml', 'erb', 'hb', 'jsp', 'css', 'hbs'] })
  call dein#add('ap/vim-css-color',
              \ { 'on_ft' : ['css', 'html', 'htm', 'haml', 'erb', 'hbls'] })
  call dein#add('chrisbra/csv.vim',
              \ { 'on_ft' : ['csv', 'tsv'] })
  call dein#add('tpope/vim-leiningen',
              \ { 'on_ft' : [ 'clj' ] })
  call dein#add('tpope/vim-projectionist',
              \ { 'on_ft' : [ 'clj' ] })
  call dein#add('tpope/vim-dispatch',
              \ { 'on_ft' : [ 'clj' ] })
  call dein#add('tpope/vim-fireplace',
              \ { 'on_ft' : [ 'clj' ] })
  call dein#add('derekwyatt/vim-scala',
              \ { 'on_ft' : [ 'scala' ] })
  call dein#add('megaannum/vimside',
              \ { 'on_ft' : [ 'scala' ] })
  call dein#add('fatih/vim-go',
              \ { 'on_ft' : [ 'go' ] })
  call dein#add('plasticboy/vim-markdown',
              \ { 'on_ft' : ['markdown', 'md', 'mkd', 'text'] })
  call dein#add('ledger/vim-ledger',
              \ { 'on_ft' : ['ledger'] })

  call dein#end()
  call dein#save_state()
endif
if dein#check_install()
  call dein#install()
endif
