if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
    au! BufRead,BufNewFile *.mot  setfiletype srec
    au! BufRead,BufNewFile *.pslt setfiletype pslt
    au! BufRead,BufNewFile *.rkt  setfiletype scheme
    au! BufRead,BufNewFile *.md   setfiletype markdown
    au! BufRead,BufNewFile SConstruct setfiletype python
    au! BufRead,BufNewFile *.scons setfiletype python
augroup END
