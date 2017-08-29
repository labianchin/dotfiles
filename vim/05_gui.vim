
if has('gui_running')
  if has("mac")
    " enabling the use of the meta key (alt/option) on the Mac
    set macmeta
    " make fullscreen the default
    set fullscreen
  endif
  if filereadable(expand("~/.gvimrc.local"))
    source ~/.gvimrc.local
  endif
endif


" ====== Vim UI
"Use color from ~/.vimrc_background or base16-tomorrow
let base16colorspace=256
if filereadable(expand("~/.vimrc_background"))
  source ~/.vimrc_background
else
  colorscheme base16-tomorrow
endif

"colorscheme hybrid
"colorscheme solarized
"colorscheme Tomorrow-Night
"colorscheme gruvbox
"colorscheme Tomorrow-Night-Eighties
