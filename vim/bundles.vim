" vim: ft=vim
" vim: syntax=vim

call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'flazz/vim-colorschemes'
"NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tpope/vim-sensible'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'Lokaltog/vim-easymotion'
"NeoBundle 'wincent/Command-T' "Not using this since ctrlp looks to be better and faster
NeoBundle 'MarcWeber/vim-addon-mw-utils'
NeoBundle 'tomtom/tlib_vim'
NeoBundle 'garbas/vim-snipmate'
NeoBundle 'honza/vim-snippets'
"NeoBundle 'Shougo/neocomplcache'
NeoBundle 'tpope/vim-surround'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'chrisbra/csv.vim'
"NeoBundle 'edkolev/tmuxline.vim'
NeoBundle 'kien/rainbow_parentheses.vim'
NeoBundle 'jpalardy/vim-slime'
NeoBundle 'jistr/vim-nerdtree-tabs'
NeoBundle 'godlygeek/tabular'
NeoBundle 'ervandew/supertab'
NeoBundle 'tpope/vim-unimpaired'


NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'vim-pandoc/vim-pandoc'
NeoBundle 'junegunn/goyo.vim'
"NeoBundle 'amix/vim-zenroom2'

NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'autowitch/hive.vim'
NeoBundle 'tommcdo/vim-exchange'
"NeoBundle 'xolox/vim-session'

call neobundle#end()