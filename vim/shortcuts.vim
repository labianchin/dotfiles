
:nmap \l :setlocal number!<CR>
:nmap \o :set paste!<CR>

" Some emacs/bash compatible commands
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

:nmap \q :nohlsearch<CR>

":nmap <C-n> :bnext<CR>
":nmap <C-p> :bprev<CR>

:nmap \e :NERDTreeToggle<CR>
noremap <silent> <F2> :NERDTreeToggle<Return>

:nmap \w :setlocal wrap!<CR>:setlocal wrap?<CR>
:set pastetoggle=<F3>
" set mapping to run make
"noremap <F5> :make<CR>
noremap <F6> :make %<CR>

" set mapping to navigate between open split windows
map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>
" set mapping to navigate in insert mode
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
" set mapping to not jump when using Shift Up/Down
noremap <S-Up> <Up>
noremap <S-Down> <Down>


" Insert a single character
 function! RepeatChar(char, count)
   return repeat(a:char, a:count)
 endfunction
 nnoremap s :<C-U>exec "normal i".RepeatChar(nr2char(getchar()), v:count1)<CR>
 nnoremap S :<C-U>exec "normal a".RepeatChar(nr2char(getchar()), v:count1)<CR>

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

" set mapping to move between tabs
noremap <C-S-Right> gt
nmap <C-Tab> gt
noremap <C-S-Left> gT
nmap <C-S-Tab> gT
" roll down and roll up
noremap <C-Down> <C-d>
noremap <C-Up> <C-u>


" Switch to alternate file
"map <C-Tab> :bnext<cr>
"map <C-S-Tab> :bprevious<cr>

" don't deselect when indenting in visual mode
vnoremap > >gv
vnoremap < <gv


" keyboard shortcuts from https://github.com/square/maximum-awesome
let mapleader = ','
map <leader>l :Align
nmap <leader>a :Ack 
nmap <leader>b :CtrlPBuffer<CR>
nmap <leader>d :NERDTreeToggle<CR>
nmap <leader>f :NERDTreeFind<CR>
nmap <leader>t :CtrlP<CR>
nmap <leader>T :CtrlPClearCache<CR>:CtrlP<CR>
nmap <leader>] :TagbarToggle<CR>
nmap <leader><space> :call whitespace#strip_trailing()<CR>
nmap <leader>g :GitGutterToggle<CR>
nmap <leader>c <Plug>Kwbd
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" adding a shortcut to toggle comment
map <C-/> <Plug>NERDCommenterToggle
map <leader>/ <Plug>NERDCommenterToggle


let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Save and run
map <F5> <Esc>:w<CR>:!%:p<CR>
imap <F5> <Esc>:w<CR>:!%:p<CR>a
