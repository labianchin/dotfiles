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
nmap \m :call ToggleMouse()<CR>
nmap \r :setlocal readonly! readonly?<CR>

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

map <C-e> :NERDTreeFind<CR>
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

" Visually select the text that was last edited/pasted based on unimpaired
nmap gV `[v`]

" expand region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" === Leader shortcuts
"let mapleader = ','
let mapleader = "\<Space>"
" adding a shortcut to toggle comment
map <leader>/ <Plug>NERDCommenterToggle
"map <leader>l :Align

nmap <leader>a :Ack<Space>
nmap <leader><space> :%s/\s\+$//e<CR>
"nmap <leader>c <Plug>Kwbd
" Reload vim
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
map <silent> <leader>r :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
" cd to the directory containing the file in the buffer
nmap <silent> <leader>cd :lcd %:h<CR>
" Map <leader>c[x|c|v] to system clipboard
vnoremap <leader>cx "+d
vnoremap <leader>cc "+y
vnoremap <leader>cv "+p
nnoremap <leader>cv "+p
" leader y as yank to OS clipboard
vmap <leader>y "+y
vmap <leader>d "+d

nnoremap <leader>q :q<CR>
nnoremap <leader>w :w<CR>
"nnoremap <leader>c :copen<CR>
"nnoremap <leader>C :cclose<CR>

" Some helpers to edit mode: http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e %%
map <leader>es :split %%
map <leader>ev :vsplit %%
map <leader>et :tabe %%

" format the entire file
nnoremap <leader>fef :normal! gg=G``<CR>
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

nnoremap <leader>gr :vimgrep
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
  "nnoremap <silent> <leader>gg :SignifyToggle<CR>
  nnoremap <silent> <leader>gm :0read !git log -1 --pretty=format:"\%s"<CR>
  nnoremap <silent> <leader>gz :! ~/bin/repl git<CR>
  nnoremap <leader>gg :Git 
"}

" Session List {
  set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
  nmap <leader>sl :SessionList<CR>
  nmap <leader>ss :SessionSave<CR>
  nmap <leader>sc :SessionClose<CR>
" }
nnoremap <silent> <leader>tt :TagbarToggle<CR>
" Underline the current line with '='
nmap <silent> <leader>ul :t.<CR>Vr=

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
"nmap <leader>l <Plug>(EasyAlign)

" === window naviation
nnoremap <leader><TAB> <C-w><C-w>

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

" set mapping to navigate in insert mode
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

" shortcut to select all
noremap <M-a> ggVG

" Bubble single lines based on unimpaired
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines based on unimpaired
vmap <C-Up> [egv
vmap <C-Down> ]egv

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

