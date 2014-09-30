" Based on:
" https://github.com/mathiasbynens/dotfiles/blob/master/.vimrc
" https://github.com/square/maximum-awesome/blob/master/vimrc
" https://github.com/skwp/dotfiles/blob/master/vimrc

" Make Vim more useful
set nocompatible
" Setting up neobundle - the vim plugin bundler
let neobundle_readme=expand('~/.vim/bundle/neobundle.vim/README.md')
if !filereadable(neobundle_readme)
    echo "Installing neobundle..."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone --depth 10 https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
    silent !mkdir -p ~/.vim/swaps
    silent !mkdir -p ~/.vim/backups
endif


set runtimepath+=~/.vim/bundle/neobundle.vim/
" load neobundle plugins
source $HOME/.vim/bundles.vim

filetype plugin indent on " filetype detection[ON] plugin[ON] indent[ON]
syntax enable             " enable syntax highlighting (previously syntax on).

" ================ General Config ====================
" enable 256-color mode
set t_Co=256
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
" make tab insert indents instead of tabs at the beginning of a line
set smarttab
" always uses spaces instead of tab characters
set expandtab
" Show “invisible” characters
set list
"set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
" Highlight problematic whitespace
set listchars=tab:▸\ ,trail:•,nbsp:_
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
set sidescrolloff=15
set sidescroll=1

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
    autocmd BufNewFile,BufRead *.md setfiletype markdown syntax=markdown
    autocmd BufNewFile,BufRead *.markdown setfiletype markdown syntax=markdown
    autocmd BufNewFile,BufRead *.csv setfiletype csv syntax=csv
    autocmd BufNewFile,BufRead *.hql setfiletype hive syntax=hive
    autocmd BufNewFile,BufRead *.gradle setfiletype groovy
    " Git commits.
    autocmd FileType gitcommit setlocal spell

    " Subversion commits.
    autocmd FileType svn       setlocal spell

    " Mercurial commits.
    autocmd FileType asciidoc  setlocal spell
  augroup END
  autocmd VimEnter * NERDTreeTabsOpen
  autocmd VimEnter * NERDTreeMirrorOpen
  autocmd VimEnter * wincmd w
endif

if has('clipboard')
    if has('unnamedplus')  " When possible use + register for copy-paste
        set clipboard=unnamedplus
    else         " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif
endif

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" Auto-indent
set autoindent
" Always indent/outdent to the nearest tabstop
set shiftround
" don't wrap text
set nowrap
" redraw only when we need to.
set lazyredraw
" highlight matching [{()}]
"set showmatch
" case-sensitive search if any caps
set smartcase
if exists('$TMUX')  " Support resizing in tmux
  set ttymouse=xterm2
endif
" allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" ====== Vim UI
set background=dark
if filereadable(expand("~/.vim/bundle/*colors*/colors/solarized.vim"))
  colorscheme solarized
  " Solarized colorscheme options, change if need
  "let g:solarized_termtrans = 1
  "let g:solarized_contrast="normal"
  "let g:solarized_visibility="normal"
  "let g:solarized_contrast = "high"
  "let g:solarized_visibility = "high"
  if has('gui_running')
  else
    "let g:solarized_termcolors = 256
    let g:solarized_termcolors = 16
  endif
endif


" ===== Load shortcuts
source $HOME/.vim/shortcuts.vim
" ===== Load plugins config
source $HOME/.vim/plugins.vim

" Use local vimrc if available {
    if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local
    endif
" }

" Use local gvimrc if available and gui is running {
    if has('gui_running')
        if filereadable(expand("~/.gvimrc.local"))
            source ~/.gvimrc.local
        endif
    endif
" }