" repeat
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

" ctrlP
"if exists('g:ctrlp_map')
  "let g:ctrlp_map = '<c-p>'
  "let g:ctrlp_cmd = 'CtrlP'
  ""let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
  "let g:ctrlp_dont_split = 'NERD_tree_2'
  "let g:ctrlp_custom_ignore = {
        "\ 'dir':  '\v[\/]\.(git|hg|svn)$',
        "\ 'file': '\v\.(exe|so|dll|o|swp|pyc|class)$',
        "\ 'link': 'SOME_BAD_SYMBOLIC_LINKS'
        "\ }
  "" CtrlP
  ""silent! nnoremap <unique> <silent> <leader>t :CtrlP<CR>
  "nnoremap <leader>p :CtrlP<CR>
  "nnoremap <leader>o :CtrlP<CR>
  "nnoremap <C-p> :CtrlP<CR>
  "nnoremap <leader>b :CtrlPBuffer<CR>
  "nnoremap <leader>T :CtrlPTag<CR>
  "nnoremap <leader>f :CtrlPFiletype<CR>
"endif

" https://sts10.github.io/blog/2016/01/09/vim-line-complete-with-fzf/
" https://github.com/zenbro/dotfiles/blob/master/.nvimrc#L221-L263<Paste>
" https://www.reddit.com/r/neovim/comments/3oeko4/post_your_fzfvim_configurations/
"if exists('g:fzf_action')
  let g:fzf_nvim_statusline = 0 " disable statusline overwriting

  nnoremap <silent> <leader>p :Files<CR>
  nnoremap <silent> <leader>b :Buffers<CR>
  nnoremap <silent> <leader>A :Windows<CR>
  nnoremap <silent> <leader>; :BLines<CR>
  nnoremap <silent> <leader>o :BTags<CR>
  nnoremap <silent> <leader>O :Tags<CR>
  nnoremap <silent> <leader>? :History<CR>
  "nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>
  nnoremap <silent> <leader>. :AgIn<Space>

  nnoremap <silent> K :call SearchWordWithAg()<CR>
  vnoremap <silent> K :call SearchVisualSelectionWithAg()<CR>
  nnoremap <silent> <leader>gl :Commits<CR>
  nnoremap <silent> <leader>ga :BCommits<CR>
  nnoremap <silent> <leader>ft :Filetypes<CR>

  imap <C-x><C-f> <plug>(fzf-complete-file-ag)
  imap <C-x><C-l> <plug>(fzf-complete-line)

  function! SearchWordWithAg()
    execute 'Ag' expand('<cword>')
  endfunction

  nnoremap <silent> <c-p> :FZF<cr>
  "nnoremap <silent> <leader>p :FZF<cr>
  nnoremap <silent> <leader>a :Ag<Space>
  " Open files in horizontal split
  if has("nvim")
    tnoremap <Space><Space> <C-\><C-n><C-w><C-p>
    tnoremap <Esc><Esc> <C-\><C-n>:q<CR>

    autocmd BufWinEnter,WinEnter term://* startinsert
    autocmd BufLeave term://* stopinsert

    imap <S-Tab> <plug>(fzf-complete-line)
  endif
"endif

let g:rainbow_active = 1

" vim-airline {
  " Use the symbols , , , , , , and .in the statusline. Otherwise comment this line.
  let g:airline_powerline_fonts = 1
  let g:airline_theme                           = 'base16'
  let g:airline#extensions#branch#enabled       = 1
  let g:airline#extensions#tagbar#enabled       = 1
  let g:airline#extensions#tabline#enabled      = 1
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline#extensions#tabline#left_sep     = ' '
  let g:airline#extensions#wordcount#enabled = 1
"}

" NerdTree {
  let NERDTreeShowBookmarks=1
  let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
  let NERDTreeChDirMode=0
  let NERDTreeQuitOnOpen=0
  let NERDTreeMouseMode=2
  let NERDTreeShowHidden=1
  let NERDTreeKeepTreeInNewTab=1

  let g:nerdtree_tabs_autofind = 1
  let g:nerdtree_tabs_open_on_console_startup = 0
" }

let g:vim_markdown_initial_foldlevel=1

"let g:indent_guides_auto_colors = 0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=lightgrey   ctermbg=3
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=darkgrey ctermbg=4

let g:fzf_action = {
  \ 'ctrl-m': 'e',
  \ 'ctrl-t': 'tabedit',
  \ 'alt-j':  'botright split',
  \ 'alt-k':  'topleft split',
  \ 'alt-h':  'vertical topleft split',
  \ 'alt-l':  'vertical botright split' }

let g:neomake_python_flake8_maker = {
    \ 'args': ['--ignore=E501,E402',  '--format=default'] }

let g:neomake_python_pylama_maker = {
    \ 'args': ['--ignore=E501,E402'] }

let g:neomake_yaml_yamllint_maker = {
    \ 'args': ['-f', 'parsable', '-d', '{extends: default, rules: {line-length: {max: 120}}}'] }

if has('nvim')
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
endif

let g:neoterm_position = 'horizontal'
let g:neoterm_automap_keys = ',tt'

nnoremap <silent> <f10> :TREPLSendFile<cr>
nnoremap <silent> <f9> :TREPLSendLine<cr>
vnoremap <silent> <f9> :TREPLSendSelection<cr>

" Useful maps
" hide/close terminal
nnoremap <silent> ,th :call neoterm#close()<cr>
" clear terminal
nnoremap <silent> ,tl :call neoterm#clear()<cr>
" kills the current job (send a <c-c>)
nnoremap <silent> ,tc :call neoterm#kill()<cr>

" Rails commands
command! Troutes :T rake routes
command! -nargs=+ Troute :T rake routes | grep <args>
command! Tmigrate :T rake db:migrate

" Git commands
command! -nargs=+ Tg :T git <args>
