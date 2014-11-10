" TODO: look at
" https://github.com/Casecommons/vim-config/blob/master/init/keybindings.vim

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
nmap \m :call ToggleMouse()<CR>
nmap \o :set paste! paste?<CR>
nmap \q :nohlsearch<CR>
nmap \r :setlocal readonly! readonly?<CR>

" Insert a single character
function! RepeatChar(char, count)
  return repeat(a:char, a:count)
endfunction
nnoremap s :<C-U>exec "normal i".RepeatChar(nr2char(getchar()), v:count1)<CR>
nnoremap S :<C-U>exec "normal a".RepeatChar(nr2char(getchar()), v:count1)<CR>
" Make Y consistent with D and C
map Y           y$
" Swap two words
nmap <silent> gw :s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>`'

" visual mode: don't deselect when indenting
vnoremap > >gv
vnoremap < <gv
" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>

"Return === Fs
map <silent> <F2> :NERDTreeToggle<CR>
set pastetoggle=<F3>
" Save and copy to clipboard
map <F4> <Esc>:w<CR>:%y+<CR>
" Save and run
map <F5> <Esc>:w<CR>:!%:p<CR>
imap <F5> <Esc>:w<CR>:!%:p<CR>a
" set mapping to run make
map <F6> :make %<CR>
" Run last command
map <F7> @:

" Tagbar key bindings."
nmap <F8> <ESC>:TagbarToggle<cr>
imap <F8> <ESC>:TagbarToggle<cr>i
" fullscreen mode for GVIM and Terminal, need 'wmctrl' in you PATH
map <silent> <F11> :call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<CR>

" Bubble single lines based on unimpaired
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines based on unimpaired
vmap <C-Up> [egv
vmap <C-Down> ]egv
" Visually select the text that was last edited/pasted based on unimpaired
nmap gV `[v`]

" === Leader shortcuts
"let mapleader = ','
let mapleader = "\<Space>"
"map <leader>l :Align
nmap <leader>a :Ack<Space>
nmap <leader><space> :call whitespace#strip_trailing()<CR>
"nmap <leader>c <Plug>Kwbd
" Reload vim
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
map <silent> <leader>r :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
" leader y as yank to OS clipboard
vmap <leader>y "+y
vmap <leader>d "+d
" expand region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
" Map <leader>c[x|c|v] to system clipboard
vnoremap <leader>cx "+d
vnoremap <leader>cc "+y
vnoremap <leader>cv "+p
nnoremap <leader>cv "+p

nnoremap <leader>q :q<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>g :vimgrep
"nnoremap <leader>c :copen<CR>
"nnoremap <leader>C :cclose<CR>
nnoremap <leader>8 :set tw=80<CR>
nnoremap <leader>0 :set tw=0<CR>
nnoremap <leader>n :set invnumber<CR>

" format the entire file
nnoremap <leader>fef :normal! gg=G``<CR>

" upper/lower word
"nmap <leader>u mQviwU`Q
"nmap <leader>l mQviwu`Q
" upper/lower first char of word
"nmap <leader>U mQgewvU`Q
"nmap <leader>L mQgewvu`Q

" cd to the directory containing the file in the buffer
nmap <silent> <leader>cd :lcd %:h<CR>

" Some helpers to edit mode
" http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e %%
map <leader>es :split %%
map <leader>ev :vsplit %%
map <leader>et :tabe %%

" Underline the current line with '='
nmap <silent> <leader>ul :t.<CR>Vr=

nnoremap <silent> <leader>tt :TagbarToggle<CR>
" Session List {
  set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
  nmap <leader>sl :SessionList<CR>
  nmap <leader>ss :SessionSave<CR>
  nmap <leader>sc :SessionClose<CR>
" }
" adding a shortcut to toggle comment
map <leader>/ <Plug>NERDCommenterToggle
" CtrlP
"silent! nnoremap <unique> <silent> <leader>t :CtrlP<CR>
silent! nnoremap <unique> <silent> <leader>p :CtrlP<CR>
silent! nnoremap <unique> <silent> <leader>o :CtrlP<CR>
silent! nnoremap <unique> <silent> <C-p> :CtrlP<CR>
silent! nnoremap <unique> <silent> <leader>b :CtrlPBuffer<CR>
silent! nnoremap <unique> <silent> <leader>T :CtrlPTag<CR>
silent! nnoremap <unique> <silent> <leader>f :CtrlPFiletype<CR>

nnoremap <leader>gt :GitGutterToggle<CR>
" Fugitive {
  nnoremap <silent> <leader>gs :Gstatus<CR>
  nnoremap <silent> <leader>gd :Gdiff<CR>
  nnoremap <silent> <leader>gc :Gcommit -v<CR>
  nnoremap <silent> <leader>gf :Gcommit -v %<CR>
  nnoremap <silent> <leader>gb :Gblame<CR>
  nnoremap <silent> <leader>gl :Glog<CR>
  nnoremap <silent> <leader>gp :Git push<CR>
  nnoremap <silent> <leader>gr :Gread<CR>
  nnoremap <silent> <leader>gw :Gwrite<CR>
  nnoremap <silent> <leader>ge :Gedit<CR>
  " Mnemonic _i_nteractive
  nnoremap <silent> <leader>gi :Git add -p %<CR>
  nnoremap <silent> <leader>gg :SignifyToggle<CR>
  nnoremap <silent> <leader>gm :0read !git log -1 --pretty=format:"\%s"<CR>
"}
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
nmap <leader>l <Plug>(EasyAlign)

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
nnoremap <leader>+ 2<C-w>+
nnoremap <leader>= <C-w>=
nnoremap <leader>_ <C-w>_

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


" NerdTree {
  map <C-e> :NERDTreeFind<CR>
" }


" set mapping to navigate between open split windows
noremap <C-J> <C-W>j<C-W>_
noremap <C-k> <C-W>k<C-W>_
noremap <C-h> <C-W>h<C-W>_
noremap <C-l> <C-W>l<C-W>_
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

" Code folding options
nmap <leader>f0 :set foldlevel=0<CR>
nmap <leader>f1 :set foldlevel=1<CR>
nmap <leader>f2 :set foldlevel=2<CR>
nmap <leader>f3 :set foldlevel=3<CR>
nmap <leader>f4 :set foldlevel=4<CR>
nmap <leader>f5 :set foldlevel=5<CR>
nmap <leader>f6 :set foldlevel=6<CR>
nmap <leader>f7 :set foldlevel=7<CR>
nmap <leader>f8 :set foldlevel=8<CR>
nmap <leader>f9 :set foldlevel=9<CR>