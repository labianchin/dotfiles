
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
"if filereadable(expand("~/.vim/bundle/*colors*/colors/hybrid.vim"))
  "colorscheme hybrid
"elseif filereadable(expand("~/.vim/bundle/*colors*/colors/solarized.vim"))
  "colorscheme solarized
  "if !has('gui_running')
    "let g:solarized_termcolors=256
    ""let g:solarized_termcolors = 16
  "endif
"endif
"colorscheme Tomorrow-Night
"let g:gruvbox_italic=0
"let g:gruvbox_contrast_dark='hard'
"colorscheme gruvbox
colorscheme Tomorrow-Night-Eighties
set background=dark
"set to light and then dark, not sure why this is needed
"set background=light