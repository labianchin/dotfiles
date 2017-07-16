" TODO: look at
" https://github.com/Casecommons/vim-config/blob/master/init/keybindings.vim

nmap \r :setlocal readonly! readonly?<CR>

" Make Y consistent with D and C
map Y           y$
" visual mode: don't deselect when indenting
vnoremap > >gv
vnoremap < <gv
" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>

" Visually select the text that was last edited/pasted based on unimpaired
nmap gV `[v`]

" expand region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

"=========== Leader key bindings
let mapleader=' '

" Basic and important
nnoremap <leader><TAB> <C-w><C-w>
map <leader>/ <Plug>NERDCommenterToggle
" Some helpers to edit mode: http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<CR>
nmap <leader>ew :e %%
nmap <leader>es :split %%
nmap <leader>ev :vsplit %%
nmap <leader>et :tabe %%
map <leader>f :Ranger<CR>
nnoremap <leader>q :q<CR>
"nnoremap <leader>qw :wq<CR>
nnoremap <leader>w :w<CR>
map <silent> <leader>r :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

nnoremap <silent> <leader>. :AgIn<Space>
nnoremap <silent> <leader>a :Ag<Space>
nnoremap <silent> <leader>p :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>A :Windows<CR>
nnoremap <silent> <leader>; :BLines<CR>
nnoremap <silent> <leader>o :BTags<CR>
nnoremap <silent> <leader>O :Tags<CR>
nnoremap <silent> <leader>? :History<CR>
"nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>

nnoremap <silent> K :call SearchWordWithAg()<CR>
vnoremap <silent> K :call SearchVisualSelectionWithAg()<CR>
nnoremap <silent> <leader>gl :Commits<CR>
nnoremap <silent> <leader>ga :BCommits<CR>
nnoremap <silent> <leader>ft :Filetypes<CR>


nmap <leader><space> :%s/\s\+$//e<CR>
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

" format the entire file
nnoremap <leader>fef :normal! gg=G``<CR>

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


function! VimuxSlime()
  call VimuxSendText(@v)
  call VimuxSendKeys("Enter")
endfunction
" Vimux
noremap <leader>vi :VimuxInspectRunner<CR>
noremap <leader>vl :VimuxRunLastCommand<CR>
noremap <leader>vp :VimuxPromptCommand<CR>
" If text is selected, save it in the v buffer and send that buffer it to tmux
vnoremap <leader>vs "vy :call VimuxSlime()<CR>
" Select current paragraph and send it to tmux
nnoremap <leader>vs vip<LocalLeader>vs<CR>
noremap <leader>vx :VimuxInterruptRunner<CR>
noremap <leader>vz :VimuxZoomRunner<CR>

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
nmap <leader>l <Plug>(EasyAlign)

" Control and Alt mappings

nnoremap <silent> <c-p> :FZF<cr>
imap <C-x><C-f> <plug>(fzf-complete-file-ag)
imap <C-x><C-l> <plug>(fzf-complete-line)

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

" === Tab naviation
nnoremap <C-t>     :tabnew<CR>
inoremap <C-t>     <Esc>:tabnew<CR>

map <C-e> :NERDTreeFind<CR>
"=========== Fs
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

nnoremap <silent> <f9> :TREPLSendLine<cr>
vnoremap <silent> <f9> :TREPLSendSelection<cr>
nnoremap <silent> <f10> :TREPLSendFile<cr>

" === Neoterm

if has('nvim')
  tnoremap <leader>q :q<CR>
  tnoremap <Esc> <C-\><C-n>
  tnoremap <A-h> <C-\><C-n><C-w>h
  tnoremap <A-j> <C-\><C-n><C-w>j
  tnoremap <A-k> <C-\><C-n><C-w>k
  tnoremap <A-l> <C-\><C-n><C-w>l
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-l> <C-\><C-n><C-w>l
  nnoremap <A-h> <C-w>h
  nnoremap <A-j> <C-w>j
  nnoremap <A-k> <C-w>k
  nnoremap <A-l> <C-w>l

  tnoremap <Space><Space> <C-\><C-n><C-w><C-p>
  tnoremap <Esc><Esc> <C-\><C-n>:q<CR>

  autocmd BufWinEnter,WinEnter term://* startinsert
  autocmd BufLeave term://* stopinsert

  imap <S-Tab> <plug>(fzf-complete-line)
endif
