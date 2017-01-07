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
  nnoremap <silent> <leader>. :AgIn 

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
  "nnoremap <silent> <leader>a :Ag<Space>
  " Open files in horizontal split
  if has("nvim")
    tnoremap <Space><Space> <C-\><C-n><C-w><C-p>
    tnoremap <Esc><Esc> <C-\><C-n>:q<CR>

    autocmd BufWinEnter,WinEnter term://* startinsert
    autocmd BufLeave term://* stopinsert

    imap <S-Tab> <plug>(fzf-complete-line)
  endif
"endif

" Rainbow parentheses
let g:rainbow_active = 1

" vim-airline {
"if exists('g:loaded_airline')
  " To use the symbols , , , , , , and .in the statusline
  " segments add the following to your .vimrc.before.local file:
  "   let g:airline_powerline_fonts=1
  " If the previous symbols do not render for you then install a
  " powerline enabled font. Or remove g:airline_powerline_fonts.
  let g:airline_powerline_fonts = 1

  let g:airline_theme                           = 'base16'
  let g:airline#extensions#branch#enabled       = 1
  let g:airline#extensions#syntastic#enabled    = 1
  let g:airline#extensions#tagbar#enabled       = 1
  let g:airline#extensions#tabline#enabled      = 1
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline#extensions#tabline#left_sep     = ' '

  " vim-powerline symbols
  let g:airline_left_sep          = ''
  let g:airline_left_alt_sep      = '⮁'
  let g:airline_right_sep         = '⮂'
  let g:airline_right_alt_sep     = '⮃'
  "let g:airline_branch_prefix     = '⭠'
  "let g:airline_readonly_symbol   = '⭤'
  "let g:airline_linecolumn_prefix = '⭡'
  if !exists('g:airline_powerline_fonts')
    " Use the default set of separators with a few customizations
    let g:airline_left_sep='›'  " Slightly fancier than '>'
    let g:airline_right_sep='‹' " Slightly fancier than '<'
  endif

"endif
"}

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
"if executable('ag')
  "" Use Ag over Ack
  "let g:ackprg = 'ag --nogroup --nocolor --column --smart-case'
  "" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  "let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
"elseif executable('ack-grep')
  "let g:ackprg="ack-grep -H --nocolor --nogroup --column"
"endif

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


" Slime
"if exists('g:loaded_slime')
  let g:slime_target = "tmux"
"endif

" ViMux
let g:VimuxOrientation = "h"
" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>
" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>
" Inspect runner pane
map <Leader>vi :VimuxInspectRunner<CR>
" Close vim tmux runner opened by VimuxRunCommand
map <Leader>vq :VimuxCloseRunner<CR>
" Interrupt any command running in the runner pane
map <Leader>vx :VimuxInterruptRunner<CR>
" Zoom the runner pane (use <bind-key> z to restore runner pane)
map <Leader>vz :call VimuxZoomRunner()<CR>

function! VimuxSlime()
 call VimuxSendText(@v)
 call VimuxSendKeys("Enter")
endfunction
" If text is selected, save it in the v buffer and send that buffer it to tmux
vmap <Leader>vs "vy :call VimuxSlime()<CR>
" Select current paragraph and send it to tmux
nmap <Leader>vs vip<Leader>vs<CR> 

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
"let g:neomake_python_enabled_makers = ['flake8']

let g:neomake_python_pylama_maker = {
    \ 'args': ['--ignore=E501,E402'] }