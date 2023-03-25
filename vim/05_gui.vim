if has("termguicolors")
  " https://github.com/alacritty/alacritty/issues/187#issuecomment-271096936
  set termguicolors
endif
let &t_ut='' " https://sw.kovidgoyal.net/kitty/faq.html#using-a-color-theme-with-a-background-color-does-not-work-well-in-vim

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


function! s:base16_customize() abort
  highlight SpellBad     cterm=standout ctermbg=0   ctermfg=Red
  highlight SpellLocal   cterm=standout ctermbg=0   ctermfg=DarkCyan
  highlight SpellCap     cterm=standout ctermbg=0   ctermfg=LightBlue
  highlight SpellRare    cterm=standout ctermbg=0   ctermfg=Magenta

  " Ensure transparent background, faster to render and better for the eyes
  highlight Normal ctermbg=none guibg=none
  highlight NonText ctermbg=none guibg=none
endfunction

augroup on_change_colorschema
  autocmd!
  autocmd ColorScheme * call s:base16_customize()
  "autocmd ColorScheme * hi Normal ctermbg=none guibg=none
augroup END


" ====== Vim UI
"Use color from ~/.vimrc_background or base16-tomorrow
"set t_Co=256 " 256 color mode
"let g:base16colorspace=256
if filereadable(expand('~/.vimrc_background'))
  source ~/.vimrc_background
else
  set background=dark
  let g:base16colorspace=256
  colorscheme base16-tomorrow-night
endif
