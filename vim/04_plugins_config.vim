set encoding=utf-8
scriptencoding utf-8
" repeat
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

" https://sts10.github.io/blog/2016/01/09/vim-line-complete-with-fzf/
" https://github.com/zenbro/dotfiles/blob/master/.nvimrc#L221-L263<Paste>
" https://www.reddit.com/r/neovim/comments/3oeko4/post_your_fzfvim_configurations/
"if exists('g:fzf_action')

  let g:fzf_nvim_statusline = 0 " disable statusline overwriting

"endif

let g:rainbow_active = 1
let g:ranger_map_keys = 0
let g:vim_markdown_initial_foldlevel=1

", 'fileencoding'
"'gitbranch',
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ], [ 'percent' ],
      \              [ 'fileformat', 'filetype', 'linter_warnings', 'linter_errors', 'linter_ok'  ] ]
      \ },
      \ 'inactive': {
      \   'left': [ [ 'bufferinfo', 'filename' ] ],
      \   'right': [ [ 'lineinfo' ], [ 'percent' ] ]
      \ },
      \ 'tabline': {
      \   'left': [ [ 'tabs' ] ],
      \   'right': []
      \ },
      \ 'tab': {
      \   'active': [ 'tabnum', 'readonly', 'filename', 'modified' ],
      \   'inactive': [ 'tabnum', 'readonly', 'filename', 'modified' ]
      \ },
      \ 'component_expand': {
      \   'gitbranch': 'fugitive#head',
      \   'linter_warnings': 'LightlineLinterWarnings',
      \   'linter_errors': 'LightlineLinterErrors',
      \   'linter_ok': 'LightlineLinterOK'
      \ },
      \ 'component_type': {
      \   'readonly': 'error',
      \   'linter_warnings': 'warning',
      \   'linter_errors': 'error'
      \ },
      \ }
      "\ 'separator': { 'left': '', 'right': '' },
      "\ 'subseparator': { 'left': '', 'right': '' }

function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ◆', all_non_errors)
endfunction
function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ✗', all_errors)
endfunction
function! LightlineLinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '✓ ' : ''
endfunction

" Update and show lightline but only if it's visible (e.g., not in Goyo)
autocmd User ALELint call s:MaybeUpdateLightline()
function! s:MaybeUpdateLightline()
  if exists('#lightline')
    call lightline#update()
  end
endfunction

let g:ale_yaml_yamllint_options = '-f parsable -d "{extends: default, rules: {line-length: {max: 120}}}"'


let b:ale_fixers = {
      \ 'python': ['black', 'isort'],
      \ 'python3': ['black', 'isort']
      \}

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
let g:fzf_preview_window = ['up:40%:hidden', 'ctrl-/']

" Git commands
command! -nargs=+ Tg :T git <args>

set shortmess+=c

if has('nvim')
  let $VISUAL = 'nvr -cc split --remote-wait'
endif

let g:neoterm_default_mod = 'botright'
let g:neoterm_automap_keys = '<leader>tm'
let g:neoterm_use_relative_path = 1
let g:neoterm_autoscroll = 1
let g:neoterm_always_open_to_exec = 0
let g:neoterm_size=12

let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'sh': ['bash-language-server', 'start'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ }

nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
"nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
let g:LanguageClient_documentHighlightDisplay={
  \     1: {
  \         'name': 'Text',
  \         'texthl': 'MatchParen',
  \     },
  \     2: {
  \         'name': 'Read',
  \         'texthl': 'MatchParen',
  \     },
  \     3: {
  \         'name': 'Write',
  \         "texthl": 'MatchParen',
  \     },
  \  }



lua << EOF
require('nvim-treesitter.configs').setup {
  -- one of "all", "maintained" (parsers with maintainers),
  -- or a list of languages
  ensure_installed = { "javascript", "java", "scala", "kotlin", "bash", "python", "c", "comment", "markdown", "yaml", },
  highlight = { -- enable highlighting
    enable = true, 
  },
}
EOF
"TODO: see https://roobert.github.io/2022/12/03/Extending-Neovim/
"lua << EOF
"require("null-ls").setup({
    "sources = {
        "null_ls.builtins.formatting.stylua,
        "null_ls.builtins.diagnostics.eslint,
        "null_ls.builtins.completion.spell,
    "},
"})
"require("lvim.lsp.null-ls.linters").setup {
  "{ command = "flake8", filetypes = { "python" } },
  "{ command = "shellcheck", extra_args = { "--severity", "warning" }, },
"}
"require("lvim.lsp.null-ls.formatters").setup {
  "{ command = "black", filetypes = { "python" } },
  "{ command = "isort", filetypes = { "python" } },
  "{ command = "shfmt", filetypes = { "sh" } },
"}
"EOF
"https://blog.pabuisson.com/2022/08/neovim-modern-features-treesitter-and-lsp/
"
"require("mason").setup()
"require("mason-lspconfig").setup {
  "-- automatically install language servers setup below for lspconfig
  "automatic_installation = true
"}

"-- Actually setup the language servers so that they're available for our
"-- LSP client. I'm mainly working with Ruby and JS, so I'm configuring
"-- language servers for these 2 languages
"local nvim_lsp = require('lspconfig')
"nvim_lsp.solargraph.setup{}
"nvim_lsp.tsserver.setup{}
