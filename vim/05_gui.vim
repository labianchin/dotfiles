
" Use local gvimrc if available and gui is running {
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
" }


" ====== Vim UI
"Use color from ~/.vimrc_background or base16-tomorrow
set background=dark
let base16colorspace=256
if filereadable(expand("~/.vimrc_background"))
  source ~/.vimrc_background
elseif
  colorscheme base16-tomorrow
endif

"If it does not work for you, use any of the following:
"if filereadable(expand("~/.vim/bundle/*colors*/colors/hybrid.vim"))
  "colorscheme hybrid
"elseif filereadable(expand("~/.vim/bundle/*colors*/colors/solarized.vim"))
  "colorscheme solarized
"endif
"colorscheme Tomorrow-Night
"colorscheme gruvbox
"colorscheme Tomorrow-Night-Eighties
