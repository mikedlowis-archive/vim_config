" Vim color file
" Maintainer:   Thorsten Maerz <info@netztorte.de>
" Last Change:  2006 Dec 07
" grey on black
" optimized for TFT panels

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
"colorscheme default
let g:colors_name = "cake"

" hardcoded colors :
" GUI Comment : #80a0ff = Light blue

" GUI
highlight Normal     guifg=Grey80   guibg=Black
highlight Search     guifg=Black    guibg=Red   gui=bold
highlight Visual     guifg=#404040              gui=bold
highlight Cursor     guifg=Black    guibg=Green gui=bold
highlight Special    guifg=Orange
highlight Comment    guifg=#80a0ff
highlight StatusLine guifg=Black    guibg=white
highlight Statement  guifg=Yellow               gui=NONE
highlight Type                                  gui=NONE
highlight CurBuf     guifg=Cyan
highlight Pmenu      guifg=White    guibg=Blue  gui=bold

" Console
highlight Normal     ctermfg=LightGrey
highlight Search     ctermfg=Black     ctermbg=Red   cterm=NONE
highlight Visual                                     cterm=reverse
highlight Cursor     ctermfg=Black     ctermbg=Green cterm=bold
highlight Special    ctermfg=Brown
highlight Comment    ctermfg=Blue
highlight StatusLine ctermfg=White     ctermbg=Black
highlight Statement  ctermfg=Yellow                  cterm=NONE
highlight Type                                       cterm=NONE
highlight CurBuf     ctermfg=Cyan
highlight Pmenu      ctermfg=White     ctermbg=Blue  cterm=bold

" only for vim 5
if has("unix")
  if v:version<600
    highlight Normal  ctermfg=Grey      ctermbg=Black  cterm=NONE guifg=Grey80    guibg=Black gui=NONE
    highlight Search  ctermfg=Black     ctermbg=Red    cterm=bold guifg=Black     guibg=Red   gui=bold
    highlight Visual  ctermfg=Black     ctermbg=yellow cterm=bold guifg=#404040               gui=bold
    highlight Special ctermfg=LightBlue                cterm=NONE guifg=LightBlue             gui=NONE
    highlight Comment ctermfg=Cyan                     cterm=NONE guifg=LightBlue             gui=NONE
  endif
endif

