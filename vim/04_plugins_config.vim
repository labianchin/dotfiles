set encoding=utf-8
scriptencoding utf-8
" repeat
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

" https://sts10.github.io/blog/2016/01/09/vim-line-complete-with-fzf/
" https://github.com/zenbro/dotfiles/blob/master/.nvimrc#L221-L263<Paste>
" https://www.reddit.com/r/neovim/comments/3oeko4/post_your_fzfvim_configurations/
"if exists('g:fzf_action')

  let g:fzf_nvim_statusline = 0 " disable statusline overwriting
  function! SearchWordWithAg()
    execute 'Ag' expand('<cword>')
  endfunction

"endif

let g:rainbow_active = 1
let g:ranger_map_keys = 0
let g:vim_markdown_initial_foldlevel=1

" vim-airline {
  " Use the symbols , , , , , , and .in the statusline. Otherwise comment this line.
  let g:airline_powerline_fonts = 1
  let g:airline_theme                           = 'base16'
  let g:airline_extensions = ['branch', 'tabline', 'wordcount', 'neomake']
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline#extensions#tabline#left_sep     = ' '
"}

" NerdTree {
  let g:NERDTreeShowBookmarks=1
  let g:NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
  let g:NERDTreeChDirMode=0
  let g:NERDTreeQuitOnOpen=0
  let g:NERDTreeMouseMode=2
  let g:NERDTreeShowHidden=1
  let g:NERDTreeKeepTreeInNewTab=1

  let g:nerdtree_tabs_autofind = 1
  let g:nerdtree_tabs_open_on_console_startup = 0
" }

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

" Git commands
command! -nargs=+ Tg :T git <args>

set shortmess+=c
