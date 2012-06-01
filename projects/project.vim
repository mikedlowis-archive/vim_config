"------------------------------------------------------------------------------
" Global Config Variables
"------------------------------------------------------------------------------
let g:ProjectPath = getcwd()
let g:TestSrcPath = g:ProjectPath . "/tests"
let g:CScopeDir   = g:ProjectPath
let g:CTagsFile   = g:CScopeDir . "/tags"

"------------------------------------------------------------------------------
" Global Config Variables
"------------------------------------------------------------------------------
" Connect to CScope
function! ConnectCScope()
    set nocscopeverbose " suppress 'duplicate connection' error
    silent! exec "cs add " . g:CScopeDir. "/cscope.out" . " " . g:CScopeDir . " -C"
    set cscopeverbose
endfunction

" Connect to the Correct CTags File
function! ConnectCTags()
    execute("set tags=" . g:CTagsFile)
endfunction

" Update the CScope Database
function! RefreshCScope()
    if strlen(g:CScopeDir)
        set nocscopeverbose
        execute('cscope kill -1')
        execute('cd ' . g:CScopeDir)
        execute('silent ! cscope -Rb')
        call ConnectCScope()
        execute('cd ' . g:ProjectPath)
    endif
endfunction

" Update the CTags File
function! RefreshCTags()
     if strlen(g:CScopeDir)
        execute('cd ' . g:CScopeDir)
        execute('silent ! ctags -R *')
        execute('cd ' . g:ProjectPath)
    endif
endfunction

"------------------------------------------------------------------------------
" Project Specific Key Mappings
"------------------------------------------------------------------------------
map <F2> <ESC>:call RefreshCTags()<CR>:call RefreshCScope()<CR>
map <F3> <ESC>:call RefreshCTags()<CR>
map <F4> <ESC>:call RefreshCScope()<CR>
map <F6> <ESC>:execute("find " . g:TestSrcPath . "/**/test_" . expand("%:t:r") . ".c")<CR>

"------------------------------------------------------------------------------
" Project Specific Key Mappings
"------------------------------------------------------------------------------
" Gentex style code formatting
if( (&ft == "c") || (&ft == "cpp") )
    setlocal cindent
    setlocal cino==1s:1s(1s
endif

"------------------------------------------------------------------------------
" Connect To CTags and CScope
"------------------------------------------------------------------------------
call ConnectCScope()
call ConnectCTags()
