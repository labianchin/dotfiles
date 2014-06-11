
" === \ change configuration
function! ToggleMouse()
  if &mouse == 'a'
    set mouse=
    echo "Mouse usage disabled"
  else
    set mouse=a
    echo "Mouse usage enabled"
  endif
endfunction
nmap \e :NERDTreeToggle<CR>
nmap \i :setlocal list! list?<CR>
nmap \l :setlocal number! number?<CR>
nmap \m :call ToggleMouse()<CR>
nmap \o :set paste! paste?<CR>
nmap \q :nohlsearch<CR>
nmap \r :setlocal relativenumber! relativenumber?<CR>
nmap \w :setlocal wrap!<CR>:setlocal wrap?<CR>

" Insert a single character
function! RepeatChar(char, count)
	return repeat(a:char, a:count)
endfunction
nnoremap s :<C-U>exec "normal i".RepeatChar(nr2char(getchar()), v:count1)<CR>
nnoremap S :<C-U>exec "normal a".RepeatChar(nr2char(getchar()), v:count1)<CR>

" Buffer Navigation
nmap <C-n> :bnext<CR>
nmap <C-p> :bprev<CR>

" Some emacs/bash compatible commands
cnoremap <C-a>  <Home>
cnoremap <C-b>  <Left>
cnoremap <C-f>  <Right>
cnoremap <C-d>  <Delete>
cnoremap <M-b>  <S-Left>
cnoremap <M-f>  <S-Right>
cnoremap <M-d>  <S-right><Delete>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>
cnoremap <Esc>d <S-right><Delete>
cnoremap <C-g>  <C-c>

" === Fs
map <silent> <F2> :NERDTreeToggle<Return>
set pastetoggle=<F3>
" Save and run
map <F5> <Esc>:w<CR>:!%:p<CR>
imap <F5> <Esc>:w<CR>:!%:p<CR>a
" set mapping to run make
map <F6> :make %<CR>

" Tagbar key bindings."
nmap <F8> <ESC>:TagbarToggle<cr>
imap <F8> <ESC>:TagbarToggle<cr>i

" visual mode: don't deselect when indenting
vnoremap > >gv
vnoremap < <gv

" === Leader shortcuts
"let mapleader = ','
let mapleader=" "
map <leader>l :Align
nmap <leader>a :Ack<Space>
nmap <leader><space> :call whitespace#strip_trailing()<CR>
nmap <leader>g :GitGutterToggle<CR>
"nmap <leader>c <Plug>Kwbd
" Reload vim
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
map <silent> <leader>r :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
" leader y as yant to OS clipboard
vmap <leader>y "+y
" Map <leader>c[x|c|v] to system clipboard
vnoremap <leader>cx "+d
vnoremap <leader>cc "+y
vnoremap <leader>cv "+p
nnoremap <leader>cv "+p

nnoremap <leader>q :q<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>e :e
nnoremap <leader>v :vsplit
nnoremap <leader>s :split
nnoremap <leader>g :vimgrep
"nnoremap <leader>c :copen<CR>
"nnoremap <leader>C :cclose<CR>
nnoremap <leader>8 :set tw=80<CR>
nnoremap <leader>0 :set tw=0<CR>
nnoremap <leader>n :set invnumber<CR>

" adding a shortcut to toggle comment
map <leader>/ <Plug>NERDCommenterToggle
" CtrlP familiar to Command-T
silent! nnoremap <unique> <silent> <leader>t :CtrlP<CR>
silent! nnoremap <unique> <silent> <leader>p :CtrlP<CR>
" CtrlP for buffers
silent! nnoremap <unique> <silent> <leader>b :CtrlPBuffer<CR>
" CtrlP for tags
silent! nnoremap <unique> <silent> <leader>T :CtrlPTag<CR>
" CtrlP for filetype
silent! nnoremap <unique> <silent> <leader>f :CtrlPFiletype<CR>

" === window naviation
nnoremap <leader><TAB> <C-w><C-w>
" keyboard shortcuts from TAB> <C-w><C-w>
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

nnoremap <leader>H <C-w>H
nnoremap <leader>J <C-w>J
nnoremap <leader>K <C-w>K
nnoremap <leader>L <C-w>L

nnoremap <leader>, 2<C-w><
nnoremap <leader>. 2<C-w>>
nnoremap <leader>- 2<C-w>-
nnoremap <leader>= 2<C-w>+

" === Tab naviation

" Go to tab by number
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
nnoremap <leader>0 :tablast<cr>

" tab navigation like firefox
" CTRL-Tab is next tab
noremap <C-Tab> :<C-U>tabnext<CR>
inoremap <C-Tab> <C-\><C-N>:tabnext<CR>
cnoremap <C-Tab> <C-C>:tabnext<CR>
" CTRL-SHIFT-Tab is previous tab
noremap <C-S-Tab> :<C-U>tabprevious<CR>
inoremap <C-S-Tab> <C-\><C-N>:tabprevious<CR>
cnoremap <C-S-Tab> <C-C>:tabprevious<CR>

nnoremap <C-t>     :tabnew<CR>
inoremap <C-t>     <Esc>:tabnew<CR>

nnoremap <C-Insert> :tabnew<CR>
nnoremap <C-Delete> :tabclose<CR>

" tab navigation like vi
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnext<Space>
nnoremap tm  :tabm<Space>

" roll down and roll up
noremap <C-Down> <C-d>
noremap <C-Up> <C-u>

" set mapping to navigate between open split windows
noremap <C-k> <C-w><Up>
noremap <C-j> <C-w><Down>
noremap <C-l> <C-w><Right>
noremap <C-h> <C-w><Left>
" set mapping to navigate in insert mode
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
" set mapping to not jump when using Shift Up/Down
noremap <S-Up> <Up>
noremap <S-Down> <Down>

" set Option-Shift-{Down-Up} to move lines up and down
nmap <silent> <M-S-j> :m+<CR>==
nmap <silent> <M-S-Down> :m+<CR>==
imap <silent> <M-S-Down> <Esc>:m+<CR>==gi
imap <silent> <M-S-j> <Esc>:m+<CR>==gi
vmap <silent> <M-S-Down> :m'>+<CR>gv=gv
vmap <silent> <M-S-j> :m'>+<CR>gv=gv
nmap <silent> <M-S-Up> :m-2<CR>==
nmap <silent> <M-S-k> :m-2<CR>==
imap <silent> <M-S-Up> <Esc>:m-2<CR>==gi
imap <silent> <M-S-k> <Esc>:m-2<CR>==gi
vmap <silent> <M-S-Up> :m-2<CR>gv=gv
vmap <silent> <M-S-k> :m-2<CR>gv=gv
" set mapping to duplicate lines
noremap <M-S-d> Y`]p
" shortcut to select all
noremap <M-a> ggVG