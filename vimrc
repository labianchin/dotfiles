

filetype on " without this vim emits a zero exit status, later, because of :ft off
filetype off
set nocompatible          " get rid of Vi compatibility mode. SET FIRST!

source $HOME/.vim/vundles.vim "load vundle plugins


filetype plugin indent on " filetype detection[ON] plugin[ON] indent[ON]
syntax enable             " enable syntax highlighting (previously syntax on).

set t_Co=256              " enable 256-color mode.
" Make backspace behave in a sane manner.
set backspace=indent,eol,start

set background=dark
if has('gui_running')
else
	let g:solarized_termcolors = 16
endif
" solarized options 
"let g:solarized_visibility = "high"
let g:solarized_termtrans = 1
"let g:solarized_contrast = "high"
colorscheme slate
"colorscheme twilight	  " Setting colorscheme to twilight

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
set hlsearch " highlight search

" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
endif

"load shortcuts
source $HOME/.vim/shortcuts.vim

if filereadable(expand("~/.vimrc.local"))
  " In your .vimrc.local, you might like:
  "
  " set autowrite
  " set nocursorline
  " set nowritebackup
  " set whichwrap+=<,>,h,l,[,] " Wrap arrow keys between lines
  "
  " autocmd! bufwritepost .vimrc source ~/.vimrc
  " noremap! jj <ESC>
  source ~/.vimrc.local
endif
