" vim: ft=vim
" vim: syntax=vim

call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'flazz/vim-colorschemes'
"NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tpope/vim-sensible'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-fugitive', { 'external_commands': 'git' }
NeoBundle 'gregsexton/gitv', { 'external_commands': 'git' }
"NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'kien/rainbow_parentheses.vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'Lokaltog/vim-easymotion'
"NeoBundle 'wincent/Command-T' "Not using this since ctrlp looks to be better and faster
NeoBundle 'MarcWeber/vim-addon-mw-utils'
NeoBundle 'tomtom/tlib_vim'
NeoBundle 'mileszs/ack.vim'
"NeoBundle 'edkolev/tmuxline.vim'
NeoBundle 'jpalardy/vim-slime'
NeoBundle 'jistr/vim-nerdtree-tabs'
NeoBundle 'godlygeek/tabular'
NeoBundle 'ervandew/supertab'

NeoBundle 'vim-pandoc/vim-pandoc'
"NeoBundle 'amix/vim-zenroom2'

NeoBundle 'tommcdo/vim-exchange'
"NeoBundle 'xolox/vim-session'
NeoBundle 'bkad/CamelCaseMotion'

NeoBundleLazy 'scrooloose/nerdtree', {'autoload':{'commands':['NERDTreeToggle', 'NERDTreeFind']}}
NeoBundleLazy 'majutsushi/tagbar', {'autoload':{'commands':['TagbarToggle']}}
NeoBundleLazy 'jlanzarotta/bufexplorer', {'autoload':{'commands':['BufExplorer']}}
NeoBundleLazy 'junegunn/goyo.vim', {'autoload':{'commands':['Goyo']}}
"NeoBundleLazy 'Shougo/neosnippet.vim', {'autoload': {'insert': 1}}
"NeoBundleLazy 'Shougo/neosnippet-snippets', {'autoload': {'insert': 1}}
NeoBundleLazy 'garbas/vim-snipmate', {'autoload': {'insert': 1}}
NeoBundleLazy 'honza/vim-snippets', {'autoload': {'insert': 1}}
NeoBundle 'chrisbra/csv.vim', { 'autoload' : { 'filetypes' : ['csv'] }}
NeoBundleLazy 'elzr/vim-json', { 'autoload' : { 'filetypes' : ['json'] }}
NeoBundleLazy 'autowitch/hive.vim', { 'autoload' : { 'filetypes' : ['hive'] }}
NeoBundleLazy 'plasticboy/vim-markdown' , { 'autoload' : { 'filetypes' : ['markdown'] }}
NeoBundleLazy 'Shougo/unite.vim', {
            \ 'autoload' : {
            \   'commands' : [{'name' : 'Unite'},
            \       'UniteWithBufferDir']
            \   }
            \ }
NeoBundleLazy 'yuratomo/w3m.vim', {
            \ 'autoload' : {
            \   'commands' : [{'name' : 'W3m'},
            \                 'W3m', 'W3mTab'],
            \   }
            \}

call neobundle#end()