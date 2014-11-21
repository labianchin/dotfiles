
filetype plugin indent on " filetype detection[ON] plugin[ON] indent[ON]
syntax enable             " enable syntax highlighting (previously syntax on).

" ================ General Config ====================
set encoding=utf-8 nobomb                                     " Use UTF-8 without BOM
set t_Co=256                                                  " enable 256-color mode
set wildmenu                                                  " Enhance command-line completion
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
set wildmode=longest,list,full
set esckeys                                                   " Allow cursor keys in insert mode
set backspace=indent,eol,start                                " Allow backspace in insert mode
set ttyfast                                                   " Optimize for fast terminal connections
set gdefault                                                  " Add the g flag to search/replace by default
set binary                                                    " Don’t add empty newlines at the end of files
set noeol

set backup                                                    " enable backups
set noswapfile                                                " disable swaps
" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/tmp/backups//
set directory=~/.vim/tmp/swaps//
set undodir=~/.vim/tmp/undo//

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
  call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
  call mkdir(expand(&directory), "p")
endif

set modeline                            " Respect modeline in files
set modelines=4
set exrc                                " Enable per-directory .vimrc files and disable unsafe commands in them
set secure
set number                              " Enable line numbers
set cursorline                          " Highlight current line
set tabstop=2                           " Make tabs as wide as two spaces
set softtabstop=2                       " unify
set shiftwidth=2                        " normal mode indentation commands use 2 spaces
set smarttab                            " make tab insert indents instead of tabs at the beginning of a line
set expandtab                           " always uses spaces instead of tab characters
set list                                " Show “invisible” characters
" set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set listchars=tab:▸\ ,trail:•,nbsp:_    " Highlight problematic whitespace
set autoindent                          " Auto-indent
set shiftround                          " Always indent/outdent to the nearest tabstop
set nowrap                              " don't wrap text
set hlsearch                            " Highlight searches
set ignorecase                          " Ignore case of searches
set incsearch                           " Highlight dynamically as pattern is typed
set laststatus=2                        " Always show status line
set mouse=a                             " Enable mouse in all modes
set noerrorbells                        " Disable error bells
set nostartofline                       " Don’t reset cursor to start of line when moving around.
set ruler                               " Show the cursor position
set shortmess=atI                       " Don’t show the intro message when starting Vim
set showmode                            " Show the current mode
set title                               " Show the filename in the window titlebar
set showcmd                             " Show the (partial) command as it’s being typed
set undofile
if exists("&relativenumber")
  set relativenumber                    " Use relative line numbers
  au BufReadPost * set relativenumber
endif
set scrolloff=3                         " Start scrolling three lines before the horizontal window border
set sidescrolloff=15
set sidescroll=1
set synmaxcol=800 " Don't try to highlight lines longer than 800 characters.

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
  augroup EditVim
    autocmd!
    " Treat .json files as .js
    autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
    autocmd BufNewFile,BufRead *.csv setfiletype csv syntax=csv
    autocmd BufNewFile,BufRead *.hql setfiletype hive
    autocmd BufNewFile,BufRead *.gradle setfiletype groovy
    autocmd BufNewFile,BufRead *.md setfiletype=markdown

    autocmd FileType markdown  setlocal spell
    autocmd FileType mkd       setlocal spell
    autocmd FileType gitcommit setlocal spell
    autocmd FileType svn       setlocal spell
    autocmd FileType asciidoc  setlocal spell
  augroup END

  " Trailing whitespace
  augroup trailing
    au!
    au InsertEnter * :set listchars-=trail:⌴
    au InsertLeave * :set listchars+=trail:⌴
  augroup END
endif

if has('clipboard')
  if has('unnamedplus')
    set clipboard=unnamedplus " When possible use + register for copy-paste
  else
    set clipboard=unnamed " On mac and Windows, use * register for copy-paste
  endif
endif

" ================ Folds ============================

set foldmethod=indent " fold based on indent
set foldnestmax=3     " deepest fold is 3 levels
set nofoldenable      " dont fold by default

set lazyredraw        " redraw only when we need to.
                      " highlight matching [{()}]
"set showmatch
set smartcase         " case-sensitive search if any caps

if exists('$TMUX')
  set ttymouse=xterm2 " Support resizing in tmux
endif
if exists('$TMUX')    " allows cursor change in tmux mode
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" ====== Vim UI
set background=dark
if filereadable(expand("~/.vim/bundle/*colors*/colors/hybrid.vim"))
  colorscheme hybrid
elseif filereadable(expand("~/.vim/bundle/*colors*/colors/solarized.vim"))
  colorscheme solarized
  if !has('gui_running')
    let g:solarized_termcolors=256
    "let g:solarized_termcolors = 16
  endif
endif

