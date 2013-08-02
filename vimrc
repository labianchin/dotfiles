

" execute pathogen#infect()
set nocompatible          " get rid of Vi compatibility mode. SET FIRST!
silent! call pathogen#infect()
filetype plugin indent on " filetype detection[ON] plugin[ON] indent[ON]
set t_Co=256              " enable 256-color mode.
" Make backspace behave in a sane manner.
set backspace=indent,eol,start

colorscheme twilight	  " Setting colorscheme to twilight
syntax enable             " enable syntax highlighting (previously syntax on).

set number                " show line numbers
set nohlsearch            " Don't continue to highlight searched phrases.
set incsearch             " But do highlight as you type your search.
set ignorecase            " Make searches case-insensitive.
set ruler                 " Always show info along bottom.

set autoindent            " auto-indent
set tabstop=4             " tab spacing
set softtabstop=4         " unify
set shiftwidth=4          " indent/outdent by 4 columns
set shiftround            " always indent/outdent to the nearest tabstop
set scrolloff=2			  " Keep Some Context: scrolloff

set nowrap                " don't wrap text


set smartcase
set hlsearch

"load shortcuts
source $HOME/.vim/shortcuts
