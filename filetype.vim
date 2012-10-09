if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  au! BufRead,BufNewFile *.mot  setfiletype srec
  au! BufRead,BufNewFile *.pslt setfiletype pslt
  au! BufRead,BufNewFile *.rkt  setfiletype scheme
augroup END
