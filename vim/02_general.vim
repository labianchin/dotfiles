if has('syntax')
  filetype plugin indent on " filetype detection[ON] plugin[ON] indent[ON]
  syntax enable             " enable syntax highlighting (previously syntax on).
endif
set background=dark

" ================ General Config ====================
if !has('nvim')
  set encoding=utf-8 nobomb                                   " Set default encoding to UTF-8, without BOM
endif
set t_Co=256                                                  " enable 256-color mode
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
set wildmode=longest,list,full
set backspace=indent,eol,start                                " Allow backspace in insert mode
set ttyfast                                                   " Optimize for fast terminal connections
set gdefault                                                  " Add the g flag to search/replace by default

set backup                                                    " enable backups
set noswapfile                                                " disable swaps
set undofile
" Centralize backups, swapfiles and undo history
set backupdir=~/.cache/vim/backups//
set directory=~/.cache/vim/swaps//
set undodir=~/.cache/vim/undo//

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
set exrc                                " Enable per-directory .vimrc files
set secure                              "  and disable unsafe commands in them
set number                              " Enable line numbers
set cursorline                          " Highlight current line
set tabstop=2                           " Make tabs as wide as two spaces
set softtabstop=2                       " unify
set shiftwidth=2                        " normal mode indentation commands use 2 spaces
set smarttab                            " make tab insert indents instead of tabs at the beginning of a line
set expandtab                           " always uses spaces instead of tab characters
set list                                " Show “invisible” characters
set listchars=tab:▸\ ,trail:•,nbsp:_    " Highlight problematic whitespace
set shiftround                          " Always indent/outdent to the nearest tabstop
set nowrap                              " don't wrap text
set hlsearch                            " Highlight searches
set ignorecase                          " Ignore case of searches
set incsearch                           " Highlight dynamically as pattern is typed
set laststatus=2                        " Always show status line
set mouse=a                             " Enable mouse in all modes
set noerrorbells                        " Disable error bells
set nostartofline                       " Don’t reset cursor to start of line when moving around.
set shortmess=atI                       " Don’t show the intro message when starting Vim
set showmode                            " Show the current mode
set title                               " Show the filename in the window titlebar
set showcmd                             " Show the (partial) command as it’s being typed
set relativenumber                      " Use relative line numbers
set scrolloff=3                         " Start scrolling three lines before the horizontal window border
set sidescrolloff=15
set sidescroll=1

set lazyredraw        " redraw only when we need to.
set synmaxcol=256
syntax sync minlines=256
set smartcase         " case-sensitive search if any caps

" better session save
set ssop-=options                       " do not store global and local values in a session
set ssop-=folds                         " do not store folds

" Automatic commands
if has("autocmd")
  augroup EditVim
    autocmd!
    autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
    autocmd BufNewFile,BufRead *.csv setfiletype csv syntax=csv
    autocmd BufNewFile,BufRead *.hql setfiletype hive
    autocmd BufNewFile,BufRead *.gradle setfiletype groovy
    autocmd BufNewFile,BufRead *.md setfiletype=markdown
    autocmd BufReadPost * set relativenumber
    autocmd BufWritePost * Neomake

    autocmd FileType markdown  setlocal spell
    autocmd FileType mkd       setlocal spell
    autocmd FileType gitcommit setlocal spell
    autocmd FileType svn       setlocal spell
    autocmd FileType asciidoc  setlocal spell

    " Trailing whitespace
    au InsertEnter * :set listchars-=trail:⌴
    au InsertLeave * :set listchars+=trail:⌴
    " Disable cursorline on insertmode
    autocmd InsertEnter,InsertLeave * set cul!
  augroup END
endif

if has('clipboard')
  if has('unnamedplus')
    set clipboard=unnamedplus " When possible use + register for copy-paste
  else
    set clipboard=unnamed " On mac and Windows, use * register for copy-paste
  endif
endif


