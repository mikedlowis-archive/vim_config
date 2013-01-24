"==============================================================================
" General Settings
"==============================================================================
let $VIMHOME=expand("<sfile>:p:h")   " Keep track of where our vim settings directory is
syntax enable                        " Turn on syntax highlighting
filetype plugin on                   " Turn on filetype plugins
filetype indent on                   " Turn off filetype indent to use custom indent settings
colorscheme cake                     " Set default color scheme
set nocompatible                     " Disable VI compatibility
set backspace=indent,eol,start       " Makes backspace work as expected
set whichwrap+=<,>,[,],h,l           " Make cursor keys wrap line
set autoindent                       " turn on auto indent
set copyindent                       " Indent follows previous line
set tabstop=4                        " Tabs equivalent to 4 spaces
set shiftwidth=4                     " Sets the size used for Vim's re-indent operator ( Shift-> and Shift-< )
set expandtab                        " Expand tabs to spaces
set softtabstop=4                    " Backspace over expanded tabs
set number                           " Turn on line numbering
set colorcolumn=80                   " Draw right margin at 80 chars
set nowrap                           " Turn off line wrapping so long lines extend off screen
set foldmethod=syntax                " Enable folds defined by syntax (i.e. functions)
set foldlevelstart=100               " Open all folds by default
set so=5                             " scrolling activates at 7 lines from the top or bottom of screen
set nobackup                         " Do not create backup files before editing
set nowritebackup                    " Do not create backup files before writing
set noswapfile                       " Do not create a swap file for files before editing
set ruler                            " Always show current cursor position
set showmatch                        " Highlight matching braces
set mat=2                            " How long to blink matching braces for
set visualbell t_vb=                 " Turn off visual and error bells
set noerrorbells                     " Turn off auditory bells
set hid                              " Change buffer without saving
set clipboard=unnamed                " Yank and Put commands use the system clipboard
set laststatus=2                     " Turn off the status line
set undodir=$VIMHOME/undo            " Set directory for storing undo files
set undofile                         " Turn on persistent undo
set cscopetag                        " Search both cscope dbs and ctags files for tags
set csto=0                           " Search cscope dbs before ctags files
set history=20                       " Save 20 lines of command history
set hlsearch                         " Turn on search highlighting
set ignorecase                       " Ignore case in searches
set smartcase                        " Don't ignore case when search term contains capitals
set incsearch                        " Highlight search string as you type
set tags=tags;/                      " Search from current directory to root for ctags db
set fileformats=unix,dos,mac         " support all three, in this order
set list                             " Show control and whitespace characters (tabs, spaces, etc.)
set listchars=tab:>-,trail:-         " Show only trailing spaces and tabs
set lazyredraw                       " Don't redraw unless we need to
set formatoptions+=r                 " Enable continuation of comments after a newline
set omnifunc=syntaxcomplete#Complete " Auto complete based on syntax
set completeopt=menu,longest         " Show a popup menu with the longest common prefix selected

"==============================================================================
" Global Variables
"==============================================================================
let g:TemplateDir = $VIMHOME . "/templates" " Directory to search for templates
let g:BufsLeft    = "" " Buffers to the left of our current buffer
let g:CurBuffer   = "" " Name of our current buffer
let g:BufsRight   = "" " Buffers to the right of the current buffer

"==============================================================================
" Function and Command Definitions
"==============================================================================
set statusline=%{g:BufsLeft}
set statusline+=%#CurBuf#
set statusline+=%{g:CurBuffer}
set statusline+=%#SyntaxLine#
set statusline+=%{g:BufsRight}
set statusline+=%<%=[%l][%c][%P][%L]%<

"==============================================================================
" Function and Command Definitions
"==============================================================================

" ToFn - Converts a group of C function prototypes to definitions
command! -range=% -nargs=0 ToFn execute "<line1>,<line2>s/;/\r{\r\r}\r/"

" Todo - Opens ~/.todo.md for editing
command! Todo edit ~/.todo.md

" LoadProject - Searches for and loads project specific settings
function! LoadProject()
    let proj = findfile("project.vim", ".;")
    let path = strpart(proj, 0, match(proj, "[\\\/]project.vim$"))

    if (!empty(path))
        silent! exec "cd " . path
    endif

    if (!empty(proj))
        exec "source " . proj
    endif
endfunction

" ReformatWhiteSpace - Convert tabs to spaces and remove trailing whitespace
function! ReformatWhiteSpace()
    if &modifiable
        retab
        silent! exec("%s/\\s\\+$//")
    endif
endfunction

" Template - Finds and inserts the text of the given template
function! Template(input)
    let tdir  = g:TemplateDir
    let tname = substitute(split(a:input,' ')[0], '\r', '', '') . '.m4'
    let targs = strpart(a:input,stridx(a:input,' ')+1)
    if filereadable( tdir . '/' . tname )
        execute(".-1read !m4 -DARGS='" . targs . "' -I" . tdir . " " . tname)
    else
        echoerr "No template found: " . tname
    endif
endfunction

" UpdateStatus - Updates the status bar to display a list of buffers
function! UpdateStatus(lmarg,rmarg)
    " Reset our Globals
    let g:CurBuffer = '[' . bufnr('%') . ' ' . expand('%:t') . ((&modified) ? ' +]' : ']')
    let g:BufsLeft = ""
    let g:BufsRight = ""

    let tot_margin = a:lmarg+ a:rmarg
    let my_left_len = (winwidth(0) - len(g:CurBuffer) - tot_margin)
    let my_right_len = 0
    let i = bufnr('$')

    while(i > 0)
        if buflisted(i) && getbufvar(i, "&modifiable") && i != bufnr('%')
            let bufName  =  '[' . i . ' ' . fnamemodify(bufname(i), ":t")
            let bufName .= (getbufvar(i, "&modified") ? ' +]' : ']' )
            if i < bufnr('%')
                let g:BufsLeft = bufName . g:BufsLeft
            else
                let g:BufsRight = bufName . g:BufsRight
            endif
        endif
        let i -= 1
    endwhile

    if len(g:BufsLeft) < my_left_len
        let my_right_len = winwidth(0) - (len(g:BufsLeft) + len(g:CurBuffer) + tot_margin)
    endif

    if len(g:BufsRight) < my_right_len
        let my_left_len = winwidth(0) - (len(g:BufsRight) + len(g:CurBuffer) + tot_margin)
    endif

    if len(g:BufsLeft) > my_left_len
        let g:BufsLeft = '<' . strpart(g:BufsLeft, len(g:BufsLeft) - my_left_len, my_left_len)
    endif

    if len(g:BufsRight) > my_right_len
        let g:BufsRight = strpart(g:BufsRight, 0, my_right_len) . '>'
    endif
endfunction

"==============================================================================
" Keyboard Mappings
"==============================================================================
" ---- Define Map Leader ----
let mapleader = ";"
let g:mapleader = ";"

" ---- Move Cursor By Display Lines ----
map j gj
map k gk

" ---- Toggle Fold ----
map  zz <ESC>za

" ---- Indenting Visual Blocks ----
vnoremap < <gv
vnoremap > >gv

" ---- Clear Search Highlighting ----
map <Leader>h :nohl<CR>

" ---- Omni Complete ----
inoremap <C-Space> <C-n>

" ---- Template Replacement ----
map ;t :call Template(getline("."))<CR>jdd

" ---- Buffer Management ----
map  <C-S-tab>  :bp<CR>
imap <C-S-tab>  <ESC>:bp<CR>
map  <C-tab>    :bn<CR>
imap <C-tab>    <ESC>:bn<CR>

" ---- Working With Windows ----
map <M-h> <C-w>h
map <M-j> <C-w>j
map <M-k> <C-w>k
map <M-l> <C-w>l
map <M-c> <C-w>c
map <M-v> :vs<CR>
map <M-s> :split<CR>

" ---- Moving Lines Around ----
nmap <C-j> ddp
imap <C-j> <ESC>ddpi
nmap <C-k> ddkP
imap <C-k> <ESC>ddkPi

" ---- CScope Mappings ----
map <Leader>fs :cs find s <cword><CR>
map <Leader>fg :cs find g <cword><CR>
map <Leader>fd :cs find d <cword><CR>
map <Leader>fc :cs find c <cword><CR>
map <Leader>ft :cs find t <cword><CR>
map <Leader>fe :cs find e <cword><CR>
map <Leader>ff :cs find f <cword><CR>
map <Leader>fi :cs find i <cword><CR>

" ---- Doxygen Comment Mappings ----
map <Leader>dc :Dox<CR>
map <Leader>da :DoxAuthor<CR>
map <Leader>dl :DoxLic<CR>

" ---- Switch between header and C file ----
map <F5> <ESC>:e %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>

"==============================================================================
" Abbreviations
"==============================================================================
" Command mode abbreviations
cnoreabbrev format <ESC><S-g>=gg
cnoreabbrev trim %s/\s\+$//
cnoreabbrev tofn ToFn
cnoreabbrev fn ToFn
cnoreabbrev <expr> ff
          \ ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs f f'  : 'ff')

"==============================================================================
" Auto Commands
"==============================================================================
" Auto locate and load project specific settings
autocmd BufEnter * call LoadProject()

" Reformat the whitespace to remove tabs and trailing space
autocmd BufWritePre * call ReformatWhiteSpace()

" Update the buffer list in the status line
autocmd VimEnter,BufNew,BufEnter,BufWritePost,VimResized,FocusLost,FocusGained,InsertLeave * call UpdateStatus(0,20)

"==============================================================================
" Doxygen Comment Configuration
"==============================================================================
" File author tag
let g:DoxygenToolkit_authorName = "Michael D. Lowis"

"==============================================================================
" GVim
"==============================================================================
if has('gui_running')
    set guioptions-=T      " no toolbar
    set guioptions-=m      " no menubar
    set guifont=Monaco:h10 " use 10 point Monaco font in gui mode

    " GVim resets this for some stupid reason so disable visual bell ... again
    autocmd GUIEnter * set visualbell t_vb=
endif
