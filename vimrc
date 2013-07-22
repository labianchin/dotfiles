

" execute pathogen#infect()
set nocompatible          " get rid of Vi compatibility mode. SET FIRST!
silent! call pathogen#infect()
filetype plugin indent on " filetype detection[ON] plugin[ON] indent[ON]
set t_Co=256              " enable 256-color mode.
" Make backspace behave in a sane manner.
set backspace=indent,eol,start

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

:nmap \l :setlocal number!<CR>
:nmap \o :set paste!<CR>


:cnoremap <C-a>  <Home>
:cnoremap <C-b>  <Left>
:cnoremap <C-f>  <Right>
:cnoremap <C-d>  <Delete>
:cnoremap <M-b>  <S-Left>
:cnoremap <M-f>  <S-Right>
:cnoremap <M-d>  <S-right><Delete>
:cnoremap <Esc>b <S-Left>
:cnoremap <Esc>f <S-Right>
:cnoremap <Esc>d <S-right><Delete>
:cnoremap <C-g>  <C-c>

:set incsearch
:set ignorecase
:set smartcase
:set hlsearch
:nmap \q :nohlsearch<CR>

:nmap <C-n> :bnext<CR>
:nmap <C-p> :bprev<CR>

:nmap \e :NERDTreeToggle<CR>

:nmap \w :setlocal wrap!<CR>:setlocal wrap?<CR>
:set pastetoggle=<F2>
