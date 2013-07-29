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

" Execute Rake with the given targets and open the quickfix window
function! RunCmd(show_qf,task)
    let cmd = 'silent !start /min cmd /c ' . a:task . ' > quickfix.txt 2>&1 ' .
              \ '&gvim --servername ' . v:servername .
              \ ' --remote-send "<ESC>:cgetfile quickfix.txt<CR>' .
              \ ((a:show_qf == 1) ? '<ESC>:cope<CR>' : '') .
              \ '<ESC>:let g:CmdRunning = 0<CR>"'

    if !exists('g:CmdRunning') || (g:CmdRunning == 0)
        execute(cmd)
        let g:CmdRunning = 1
    else
        echoerr 'Error: A background command is already running!'
    endif
endfunction

" Define a rake command
command! -nargs=* Rake call RunCmd(1, 'rake ' . '<args>')
cnoreabbrev rake Rake

" Define a rake command
command! -nargs=* Exec call RunCmd(0, '<args>')
cnoreabbrev exec Exec
cnoreabbrev cmd Exec

"------------------------------------------------------------------------------
" Project Specific Key Mappings
"------------------------------------------------------------------------------
map <silent> <F2>  <F3><F4>
map <silent> <F3>  <ESC>:call RefreshCTags()<CR>
map <silent> <F4>  <ESC>:call RefreshCScope()<CR>
map <silent> <F6>  <ESC>:execute("find " . g:TestSrcPath . "/**/test_" . expand("%:t:r") . ".c")<CR>
map <silent> <F7>  <ESC>:Rake test:%:t:r.c<CR>
map <silent> <F8>  <ESC>:Rake bullseye:%:t:r.c<CR>
map <silent> <F9>  <ESC>:call RunCmd(1,'grep -rEn "TODO\|@bug\|@fix" Code/ Test/')<CR>
map <silent> <F10> <ESC>:Rake release<CR>
map <silent> <F12> <ESC>:Rake debug<CR>

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
    setlocal cino={1s=1s:1s(1s
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
