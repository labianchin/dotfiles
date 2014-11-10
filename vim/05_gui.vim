
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
