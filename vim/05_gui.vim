if has("termguicolors")
  " https://github.com/alacritty/alacritty/issues/187#issuecomment-271096936
  set termguicolors
endif

if has('gui_running')
  if has('mac')
    " enabling the use of the meta key (alt/option) on the Mac
    set macmeta
    " make fullscreen the default
    set fullscreen
  endif
  if filereadable(expand('~/.gvimrc.local'))
    source ~/.gvimrc.local
  endif
endif


" ====== Vim UI
"Use color from ~/.vimrc_background or base16-tomorrow
"set background=dark
"set t_Co=256 " 256 color mode
let g:base16colorspace=256
if filereadable(expand('~/.vimrc_background'))
  source ~/.vimrc_background
else
  colorscheme base16-tomorrow-night
endif
let &t_ut='' " https://sw.kovidgoyal.net/kitty/faq.html#using-a-color-theme-with-a-background-color-does-not-work-well-in-vim
" since these colors were not nice
highlight SpellBad     cterm=standout ctermbg=0   ctermfg=Red
highlight SpellCap     cterm=standout ctermbg=0   ctermfg=LightBlue
highlight SpellRare    cterm=standout ctermbg=0   ctermfg=Magenta
highlight SpellLocal   cterm=standout ctermbg=0   ctermfg=DarkCyan

