" Vim syntax file
" Language:     Axio
" Maintainer:   Mike Lowis <mike@mdlowis.com>
" Last Change:  2012 March 25

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syn keyword     cConditional    if else switch


hi def link cConditional        Conditional

let b:current_syntax = "axio"
