" vim: ft=vim syntax=vim

let s:bundle_folder='~/.vim/bundle'
let s:neobundle_folder=s:bundle_folder . '/neobundle.vim/'

if has('vim_starting')
  " Setting up neobundle - the vim plugin bundler
  if !filereadable(expand(s:neobundle_folder . 'README.md'))
    echo "Installing neobundle into " . s:neobundle_folder . " ..."
    call mkdir(expand(s:bundle_folder), "p")
    echom system('git clone --depth 10 https://github.com/Shougo/neobundle.vim ' . expand(s:neobundle_folder))
  endif

  execute 'set runtimepath^=' . s:neobundle_folder
endif

let g:neobundle#types#git#clone_depth = 5
call neobundle#begin(expand(s:bundle_folder))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'bling/vim-airline'
NeoBundle 'luochen1990/rainbow'
NeoBundle 'tpope/vim-sensible'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-rsi'
NeoBundle 'tpope/vim-sleuth'
NeoBundle 'tpope/vim-fugitive', { 'external_commands': 'git' }
NeoBundle 'gregsexton/gitv', { 'external_commands': 'git' }
NeoBundle 'MarcWeber/vim-addon-mw-utils' " vim: interpret a file by function and cache file automatically
NeoBundle 'tomtom/tlib_vim'              " Some utility functions for VIM
NeoBundle 'mileszs/ack.vim'              " Run your favorite search tool from Vim
NeoBundle 'ervandew/supertab'            " Perform all your vim insert mode completions with Tab
"NeoBundle 'scrooloose/nerdtree'          " A tree explorer plugin for vim.
"NeoBundle 'jistr/vim-nerdtree-tabs'      " NERDTree and tabs together in Vim, painlessly
NeoBundle 'maxbrunsfeld/vim-yankstack'   " lightweight implementation of emacs's kill-ring for vim
NeoBundle 'moll/vim-bbye'                " Delete buffers and close files without closing windows or messing up layout
NeoBundle 'mhinz/vim-startify'           " A fancy start screen for Vim
NeoBundle 'sheerun/vim-polyglot'         " Language packs, with syntax, ftplugin, ftdetect, ...

" Motion/visual
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'bkad/CamelCaseMotion'
NeoBundle 'tommcdo/vim-exchange'
NeoBundle 'terryma/vim-expand-region'
NeoBundle 'nathanaelkane/vim-indent-guides'

" Tmux integration
NeoBundle 'jpalardy/vim-slime'
NeoBundle 'benmills/vimux'
NeoBundle 'christoomey/vim-tmux-navigator'


NeoBundleLazy 'scrooloose/nerdtree',
            \ {'autoload':{'commands':['NERDTreeToggle', 'NERDTreeFind', 'NERDTree', 'NERDTreeMirrorOpen', 'NERDTreeTabsOpen']}}
NeoBundleLazy 'ctrlpvim/ctrlp.vim',
            \ {'autoload':{'commands':['CtrlP', 'CtrlPBuffer', 'CtrlPTag']}}
NeoBundleLazy 'godlygeek/tabular',
            \ {'autoload':{'commands':['Tabularize']}}
NeoBundleLazy 'majutsushi/tagbar',
            \ {'autoload':{'commands':['TagbarToggle']}}
NeoBundleLazy 'jlanzarotta/bufexplorer',
            \ {'autoload':{'commands':['BufExplorer']}}
NeoBundleLazy 'junegunn/goyo.vim',
            \ {'autoload':{'commands':['Goyo']}}
NeoBundleLazy 'junegunn/vim-easy-align',
            \ {'autoload':{'commands':['EasyAlign']}}
NeoBundleLazy 'garbas/vim-snipmate',
            \ {'autoload': {'insert': 1}}
NeoBundleLazy 'honza/vim-snippets',
            \ {'autoload': {'insert': 1}}
" Frontend
NeoBundleLazy 'othree/xml.vim',
            \ {'autoload' : { 'filetypes' : ['xml', 'html', 'htm', 'erb', 'hb', 'jsp'] }}
NeoBundleLazy 'mattn/emmet-vim',
            \ {'autoload' : { 'filetypes' : ['xml', 'html', 'htm', 'erb', 'hb', 'jsp', 'css'] }}
NeoBundleLazy 'ap/vim-css-color',
            \ {'autoload' : { 'filetypes' : ['css', 'html', 'haml', 'erb'] }}
NeoBundleLazy 'yuratomo/w3m.vim',
            \ {'autoload' : { 'commands' : [{'name' : 'W3m'}, 'W3m', 'W3mTab'], }}
NeoBundleLazy 'chrisbra/csv.vim',
            \ {'autoload' : { 'filetypes' : ['csv', 'tsv'] }}
" Clojure
NeoBundleLazy 'tpope/vim-leiningen',
            \ {'autoload': { 'filetypes' : [ 'clj' ] }}
NeoBundleLazy 'tpope/vim-projectionist',
            \ {'autoload': { 'filetypes' : [ 'clj' ] }}
NeoBundleLazy 'tpope/vim-dispatch',
            \ {'autoload': { 'filetypes' : [ 'clj' ] }}
NeoBundleLazy 'tpope/vim-fireplace',
            \ {'autoload': { 'filetypes' : [ 'clj' ] }}
NeoBundleLazy 'fatih/vim-go',
            \ {'autoload': { 'filetypes' : [ 'go' ] }}
NeoBundleLazy 'autowitch/hive.vim',
            \ {'autoload' : { 'filetypes' : ['hive', 'q', 'sql', 'hql'] }}
NeoBundleLazy 'plasticboy/vim-markdown',
            \ {'autoload' : { 'filetypes' : ['markdown', 'md', 'mkd', 'text'] }}
NeoBundleLazy 'ledger/vim-ledger',
            \ {'autoload' : { 'filetypes' : ['ledger'] }}
NeoBundleLazy 'xolox/vim-easytags',
            \ {'autoload':{'commands':['UpdateTags', 'HighlightTags']}}

" Graveyard
"NeoBundle 'altercation/vim-colors-solarized'
"NeoBundle 'Shougo/neocomplcache'
"NeoBundle 'wincent/Command-T' "Not using this since ctrlp looks to be better and faster
"NeoBundle 'edkolev/tmuxline.vim'
"NeoBundle 'vim-pandoc/vim-pandoc'
"NeoBundle 'amix/vim-zenroom2'
"NeoBundle 'xolox/vim-session'
"NeoBundle 'myusuf3/numbers.vim'
"NeoBundle 'Shougo/vimshell.vim'
"NeoBundleLazy 'Shougo/neosnippet.vim', {'autoload': {'insert': 1}}
"NeoBundleLazy 'Shougo/neosnippet-snippets', {'autoload': {'insert': 1}}
"NeoBundleLazy 'Shougo/unite.vim', {
            "\ 'autoload' : {
            "\   'commands' : [{'name' : 'Unite'},
            "\       'UniteWithBufferDir']
            "\   }
            "\ }
" Parenthesis matching
"NeoBundle 'Raimondi/delimitMate'
"NeoBundle 'jiangmiao/auto-pairs'


call neobundle#end()