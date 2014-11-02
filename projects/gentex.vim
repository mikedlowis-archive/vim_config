"------------------------------------------------------------------------------
" Global Config Variables
"------------------------------------------------------------------------------
let g:ProjectPath = getcwd()
let g:TestSrcPath = g:ProjectPath . "/Test/Unit/Application/Source"
let g:CScopeDir   = g:ProjectPath . "/Code"
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
        execute('cd ' . g:ProjectPath)
        call ConnectCScope()
    endif
    redraw!
endfunction

" Update the CTags File
function! RefreshCTags()
     if strlen(g:CScopeDir)
        execute('cd ' . g:CScopeDir)
        execute('silent ! ctags -R *')
        execute('cd ' . g:ProjectPath)
    endif
    redraw!
endfunction

"------------------------------------------------------------------------------
" Project Specific Key Mappings
"------------------------------------------------------------------------------
map <F2> <ESC>:call RefreshCTags()<CR>:call RefreshCScope()<CR>
map <F3> <ESC>:call RefreshCTags()<CR>
map <F4> <ESC>:call RefreshCScope()<CR>
map <F6> <ESC>:execute("find " . g:TestSrcPath . "/**/test_" . expand("%:t:r") . ".c")<CR>

"==============================================================================
" Doxygen Comment Configuration
"==============================================================================
" File author tag
let g:DoxygenToolkit_authorTag = ""
let g:DoxygenToolkit_authorName = "$Author$"

" File version tag
let g:DoxygenToolkit_versionTag = ""
let g:DoxygenToolkit_versionString = "$Revision$"

" File date tag
let g:DoxygenToolkit_dateTag = ""
let g:DoxygenToolkit_dateString = "$Date$"

" Extra Info for File Header
let g:DoxygenToolkit_extraTag = ""
let g:DoxygenToolkit_authorExtra = "$HeadURL$"

"------------------------------------------------------------------------------
" Project Specific Key Mappings
"------------------------------------------------------------------------------
" Gentex style code formatting
if( (&ft == "c") || (&ft == "cpp") )
    setlocal cindent
    setlocal cino==1s:1s(1s
elseif(&ft == "ruby")
    setlocal tabstop=2
    setlocal shiftwidth=2
    set softtabstop=2
endif

"------------------------------------------------------------------------------
" Connect To CTags and CScope
"------------------------------------------------------------------------------
call ConnectCScope()
call ConnectCTags()
