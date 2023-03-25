set encoding=utf-8
scriptencoding utf-8

if has('syntax')
  filetype plugin indent on " filetype detection[ON] plugin[ON] indent[ON]
  syntax enable             " enable syntax highlighting (previously syntax on).
endif

" https://www.rogin.xyz/blog/sensible-neovim
" Allows you to change buffers even if the current on has unsaved changes
set hidden
" Intuit the indentation of new lines when creating them
set smartindent
" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" ================ General Config ====================
if !has('nvim')
  set encoding=utf-8 nobomb                                   " Set default encoding to UTF-8, without BOM
endif
if !has('gui_running')
  set t_Co=256
endif
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
set wildmode=longest,list,full
set backspace=indent,eol,start                                " Allow backspace in insert mode
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
  call mkdir(expand(&undodir), 'p')
endif
if !isdirectory(expand(&backupdir))
  call mkdir(expand(&backupdir), 'p')
endif
if !isdirectory(expand(&directory))
  call mkdir(expand(&directory), 'p')
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
set smartcase                           " case-sensitive search if any caps

set lazyredraw                          " redraw only when we need to.
set synmaxcol=256
syntax sync minlines=256

" better session save
set sessionoptions-=options                       " do not store global and local values in a session
set sessionoptions-=folds                         " do not store folds

set timeout ttimeout
set timeoutlen=750  " Time out on mappings
set updatetime=1000 " Idle time to write swap and trigger CursorHold
" Time out on key codes
if has('nvim')
  " https://github.com/neovim/neovim/issues/2017
  set ttimeoutlen=-1
else
  set ttimeoutlen=10
endif

set noshowmode

" Automatic commands
if has('autocmd')
  augroup EditVim
    autocmd!
    autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
    autocmd BufNewFile,BufRead *.csv setfiletype csv syntax=csv
    autocmd BufNewFile,BufRead *.hql setfiletype hive
    autocmd BufNewFile,BufRead *.gradle setfiletype groovy
    autocmd BufNewFile,BufRead *.md setfiletype=markdown
    autocmd BufReadPost * set relativenumber

    autocmd FileType markdown  setlocal spell
    autocmd FileType mkd       setlocal spell
    autocmd FileType gitcommit setlocal spell
    autocmd FileType svn       setlocal spell
    autocmd FileType asciidoc  setlocal spell

    " Trailing whitespace
    autocmd InsertEnter * :set listchars-=trail:⌴
    autocmd InsertLeave * :set listchars+=trail:⌴
    autocmd BufEnter * if &buftype == 'terminal' | :highlight TermCursor ctermfg=red guifg=red | endif
    " Disable cursorline on insertmode
    autocmd InsertEnter,InsertLeave * set cul!

    " enable ncm2 for all buffers
    "autocmd BufEnter * call ncm2#enable_for_buffer()

    autocmd InsertEnter,InsertLeave * set cul!
  augroup END
endif


" :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

if has('folding')
  set foldenable
  set foldmethod=syntax
  set foldlevelstart=99
  set foldtext=FoldText()
endif

if has('clipboard')
  if has('unnamedplus')
    set clipboard=unnamedplus " When possible use + register for copy-paste
  else
    set clipboard=unnamed " On mac and Windows, use * register for copy-paste
  endif
endif

" http://owen.cymru/fzf-ripgrep-navigate-with-bash-faster-than-ever-before/
set grepprg=rg\ --vimgrep
let g:ackprg = 'rg --vimgrep --no-heading'
let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
  \ -g "!{.git,node_modules,vendor}/*" '

command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)

let s:tmux = exists('$TMUX')
" Tmux specific settings
" ---
if s:tmux
	set ttyfast

	" Set Vim-specific sequences for RGB colors
	" Fixes 'termguicolors' usage in tmux
	" :h xterm-true-color
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

	" Assigns some xterm(1)-style keys to escape sequences passed by tmux
	" when 'xterm-keys' is set to 'on'.  Inspired by an example given by
	" Chris Johnsen at https://stackoverflow.com/a/15471820
	" Credits: Mark Oteiza
	" Documentation: help:xterm-modifier-keys man:tmux(1)
	execute "set <xUp>=\e[1;*A"
	execute "set <xDown>=\e[1;*B"
	execute "set <xRight>=\e[1;*C"
	execute "set <xLeft>=\e[1;*D"

	execute "set <xHome>=\e[1;*H"
	execute "set <xEnd>=\e[1;*F"

	execute "set <Insert>=\e[2;*~"
	execute "set <Delete>=\e[3;*~"
	execute "set <PageUp>=\e[5;*~"
	execute "set <PageDown>=\e[6;*~"

	execute "set <xF1>=\e[1;*P"
	execute "set <xF2>=\e[1;*Q"
	execute "set <xF3>=\e[1;*R"
	execute "set <xF4>=\e[1;*S"

	execute "set <F5>=\e[15;*~"
	execute "set <F6>=\e[17;*~"
	execute "set <F7>=\e[18;*~"
	execute "set <F8>=\e[19;*~"
	execute "set <F9>=\e[20;*~"
	execute "set <F10>=\e[21;*~"
	execute "set <F11>=\e[23;*~"
	execute "set <F12>=\e[24;*~"
endif
