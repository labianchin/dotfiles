" repeat
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

" ctrlP
"if exists('g:ctrlp_map')
  let g:ctrlp_map = '<c-p>'
  let g:ctrlp_cmd = 'CtrlP'
  "let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
  let g:ctrlp_dont_split = 'NERD_tree_2'
  let g:ctrlp_custom_ignore = {
        \ 'dir':  '\v[\/]\.(git|hg|svn)$',
        \ 'file': '\v\.(exe|so|dll|o|swp|pyc|class)$',
        \ 'link': 'SOME_BAD_SYMBOLIC_LINKS'
        \ }
  " CtrlP
  "silent! nnoremap <unique> <silent> <leader>t :CtrlP<CR>
  silent! nnoremap <unique> <silent> <leader>p :CtrlP<CR>
  silent! nnoremap <unique> <silent> <leader>o :CtrlP<CR>
  silent! nnoremap <unique> <silent> <C-p> :CtrlP<CR>
  silent! nnoremap <unique> <silent> <leader>b :CtrlPBuffer<CR>
  silent! nnoremap <unique> <silent> <leader>T :CtrlPTag<CR>
  silent! nnoremap <unique> <silent> <leader>f :CtrlPFiletype<CR>
"endif

" Rainbow parentheses
"let g:rbpt_colorpairs = [
    "\ ['magenta',     'purple1'],
    "\ ['cyan',        'magenta1'],
    "\ ['green',       'slateblue1'],
    "\ ['yellow',      'cyan1'],
    "\ ['red',         'springgreen1'],
    "\ ['magenta',     'green1'],
    "\ ['cyan',        'greenyellow'],
    "\ ['green',       'yellow1'],
    "\ ['yellow',      'orange1'],
    "\ ]
"let g:rbpt_colorpairs = [
  "\ [ '13', '#6c71c4'],
  "\ [ '5',  '#d33682'],
  "\ [ '1',  '#dc322f'],
  "\ [ '9',  '#cb4b16'],
  "\ [ '3',  '#b58900'],
  "\ [ '2',  '#859900'],
  "\ [ '6',  '#2aa198'],
  "\ [ '4',  '#268bd2'],
  "\ ]
let g:rbpt_max = 9
" Enable rainbow parentheses for all buffers
"let g:rbpt_loadcmd_toggle = 1
augroup rainbow_parentheses
  au!
  au VimEnter * RainbowParenthesesToggle
  au Syntax * RainbowParenthesesLoadRound
  au Syntax * RainbowParenthesesLoadSquare
  au Syntax * RainbowParenthesesLoadBraces
  au Syntax * RainbowParenthesesLoadChevrons
  "au syntax * cal rainbow#load()
  "au syntax * cal rainbow#activate()
augroup END

" vim-airline {
"if exists('g:loaded_airline')
  " To use the symbols , , , , , , and .in the statusline
  " segments add the following to your .vimrc.before.local file:
  "   let g:airline_powerline_fonts=1
  " If the previous symbols do not render for you then install a
  " powerline enabled font. Or remove g:airline_powerline_fonts.
  let g:airline_powerline_fonts = 1

  let g:airline_theme             = 'badwolf'
  let g:airline#extensions#branch#enabled = 1
  let g:airline#extensions#syntastic#enabled = 1
  let g:airline#extensions#tagbar#enabled = 1
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline#extensions#tabline#left_sep = ' '

  if !exists('g:airline_powerline_fonts')
    " Use the default set of separators with a few customizations
    let g:airline_left_sep='›'  " Slightly fancier than '>'
    let g:airline_right_sep='‹' " Slightly fancier than '<'
  endif

  " vim-powerline symbols
  let g:airline_left_sep          = ''
  let g:airline_left_alt_sep      = '⮁'
  let g:airline_right_sep         = '⮂'
  let g:airline_right_alt_sep     = '⮃'
  "let g:airline_branch_prefix     = '⭠'
  "let g:airline_readonly_symbol   = '⭤'
  "let g:airline_linecolumn_prefix = '⭡'
"endif
"}

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Ack
  let g:ackprg = 'ag --nogroup --nocolor --column --smart-case'
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
elseif executable('ack-grep')
  let g:ackprg="ack-grep -H --nocolor --nogroup --column"
endif

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