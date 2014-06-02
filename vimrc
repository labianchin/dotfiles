" Based on:
" https://github.com/mathiasbynens/dotfiles/blob/master/.vimrc
" https://github.com/square/maximum-awesome/blob/master/vimrc

" Make Vim more useful
set nocompatible
" without this vim emits a zero exit status, later, because of :ft off
filetype on
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" load vundle plugins
source $HOME/.vim/vundles.vim

filetype plugin indent on " filetype detection[ON] plugin[ON] indent[ON]
syntax enable             " enable syntax highlighting (previously syntax on).

colorscheme solarized

" enable 256-color mode
set t_Co=256
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed
" Enhance command-line completion
set wildmenu
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
set wildmode=longest,list,full
" Allow cursor keys in insert mode
set esckeys
" Allow backspace in insert mode
set backspace=indent,eol,start 
" Optimize for fast terminal connections
set ttyfast
" Add the g flag to search/replace by default
set gdefault
" Use UTF-8 without BOM
set encoding=utf-8 nobomb
" Don’t add empty newlines at the end of files
set binary
set noeol
" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
endif

" Respect modeline in files
set modeline
set modelines=4
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
" Enable line numbers
set number
" Highlight current line
set cursorline
" Make tabs as wide as two spaces
set tabstop=2
set softtabstop=2         " unify
" normal mode indentation commands use 2 spaces
set shiftwidth=2
" Show “invisible” characters
set list
"set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set listchars=tab:▸\ ,trail:▫,nbsp:_
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
" Highlight dynamically as pattern is typed
set incsearch
" Always show status line
set laststatus=2
" Enable mouse in all modes
set mouse=a
" Disable error bells
set noerrorbells
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Don’t show the intro message when starting Vim
set shortmess=atI
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it’s being typed
set showcmd
" Use relative line numbers
if exists("&relativenumber")
	set relativenumber
	au BufReadPost * set relativenumber
endif
" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>

" Automatic commands
if has("autocmd")
	" Treat .json files as .js
	autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
endif


" Auto-indent
set autoindent
" Always indent/outdent to the nearest tabstop
set shiftround
" don't wrap text
set nowrap
" case-sensitive search if any caps
set smartcase
if exists('$TMUX')  " Support resizing in tmux
  set ttymouse=xterm2
endif

" Solarized colorscheme options, change if need
"let g:solarized_visibility = "high"
"let g:solarized_termtrans = 1
"let g:solarized_contrast = "high"
set background=dark
if has('gui_running')
else
	let g:solarized_termcolors = 16
endif


" ===== Load shortcuts
source $HOME/.vim/shortcuts.vim
" ===== Load plugins config
source $HOME/.vim/plugins.vim

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