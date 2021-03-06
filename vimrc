"==============================================================================
" General Settings
"==============================================================================
let $VIMHOME=expand("<sfile>:p:h")   " Keep track of where our vim settings directory is
set background=dark                  " Set background style to dark for colorschemes
syntax enable                        " Turn on syntax highlighting
filetype plugin on                   " Turn on filetype plugins
filetype indent on                   " Turn off filetype indent to use custom indent settings
let g:solarized_termtrans=1
colorscheme solarized                " Set default color scheme
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
set clipboard=unnamedplus            " Yank and Put commands use the system clipboard
set laststatus=2                     " Turn on the status line always
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
set wildmode=list:full
set wildmenu
set title

"==============================================================================
" Global Variables
"==============================================================================
let g:TodoList    = "~/.todo.md"
let g:TemplateDir = $VIMHOME . "/templates" " Directory to search for templates

"==============================================================================
" Function and Command Definitions
"==============================================================================

" ToFn - Converts a group of C function prototypes to definitions
command! -range=% -nargs=0 ToFn execute "<line1>,<line2>s/;/\r{\r\r}\r/"

" Todo - Opens g:TodoList for editing
command! Todo execute "edit " . g:TodoList

" Template - Opens the specified template for editing
command! -nargs=1 Template execute "edit " . g:TemplateDir . "/" . <f-args> . ".m4"

" LoadProject - Searches for and loads project specific settings
function! LoadProject()
    let proj = findfile("project.vim", ".;")
    let path = strpart(proj, 0, match(proj, "[\\\/]project.vim$"))

    if (!empty(path))
        silent! exec "cd " . path
    endif

    if (!empty(proj))
        exec "source project.vim"
    endif
endfunction

" ReformatWhiteSpace - Convert tabs to spaces and remove trailing whitespace
function! ReformatWhiteSpace()
    let line_num = line(".")
    if &modifiable
        retab
        silent! exec("%s/\\s\\+$//")
    endif
    execute(":" . line_num)
endfunction

" Template - Finds and inserts the text of the given template
function! Template(input)
    let tdir  = g:TemplateDir
    let tname = substitute(split(a:input,' ')[0], '\r', '', '') . '.m4'
    let targs = strpart(a:input,stridx(a:input,' ')+1)
    if filereadable( tdir . '/' . tname )
        execute(".-1read !m4 -DARGS='" . targs . "' -I" . tdir . " " . tname)
        let line_num = line(".")
        execute("normal G=gg")
        execute(":" . line_num)
    else
        echoerr "No template found: " . tname
    endif
endfunction

"  UpdateStatus - Updates the status bar to display a list of buffers
function! UpdateStatus(lmarg,rmarg)
    " Reset our Globals
    let g:CurBuffer =  bufnr('%') . ' ' . expand('%:t')
    let g:BufsLeft = ""
    let g:BufsRight = ""

    let tot_margin = a:lmarg + a:rmarg
    let my_left_len = (winwidth(0) - len(g:CurBuffer) - tot_margin)
    let my_right_len = 0
    let i = bufnr('$')

    while(i > 0)
        if buflisted(i) && getbufvar(i, "&modifiable") && i != bufnr('%')
            let bufName  =  i . ' ' . fnamemodify(bufname(i), ":t") " . ' | '
            let bufName .= (getbufvar(i, "&modified") ? ',+' : '' )
            if i < bufnr('%')
                let g:BufsLeft = ' ' . bufName . ' |' . g:BufsLeft
            else
                let g:BufsRight = '| ' . bufName . ' ' . g:BufsRight
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

    set statusline=%{g:BufsLeft}
    set statusline+=%#CurBuf#
    set statusline+=\ %{g:CurBuffer}%M
    set statusline+=\ %#SyntaxLine#
    set statusline+=%{g:BufsRight}
    set statusline+=%<%=[%l][%c][%P][%L]%<
endfunction

"==============================================================================
" Spell Checking Rules For Code
"==============================================================================
function! SpellCheck()
    " Turn on spell checking
    set spell
    " Ignore Doxygen Tags
    syn match DoxyTags /[@\\][a-z]\+/ contains=@NoSpell transparent
    syn cluster Spell add=DoxyTags
    " Ignore Camel Cased Identifiers
    syn match CamelCase /[A-Z][a-z0-9_]*[A-Z][A-Za-z0-9_]*/ contains=@NoSpell transparent
    syn cluster Spell add=CamelCase
    " Ignore Variable Names
    syn match VarNames /[a-z0-9]\+_[a-z0-9_]*/ contains=@NoSpell transparent
    syn cluster Spell add=VarNames
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
map zz <ESC>za

" ---- Indenting Visual Blocks ----
vnoremap < <gv
vnoremap > >gv

" ---- Clear Search Highlighting ----
map <Leader>h :set hlsearch!<CR>

" ---- Re-Enable search highlighting for new searches ----
noremap * :set hlsearch<CR>:nohlsearch<CR>*
noremap / :set hlsearch<CR>:nohlsearch<CR>/
noremap ? :set hlsearch<CR>:nohlsearch<CR>?

" ---- Toggle Spell  Checking ----
map <Leader>s :set spell!<CR>

" ---- Clear Search Highlighting ----
map <Leader>n :set number!<CR>

" ---- Omni Complete ----
inoremap <C-Space> <C-n>

" ---- Template Replacement ----
map <Leader>t :call Template(getline("."))<CR>jdd

" ---- Buffer Management ----
map  <C-h>  :bp<CR>
imap <C-h>  <ESC>:bp<CR>
map  <C-l>  :bn<CR>
imap <C-l>  <ESC>:bn<CR>

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
" Automatically turn on spell checking
autocmd BufRead,BufNewFile * call SpellCheck()

" Auto locate and load project specific settings
autocmd BufEnter * call LoadProject()

" Reformat the whitespace to remove tabs and trailing space
autocmd BufWritePre * call ReformatWhiteSpace()

" Update the buffer list in the status line
autocmd BufEnter * call UpdateStatus(5,20)

"==============================================================================
" Doxygen Comment Configuration
"==============================================================================
" File author tag
let g:DoxygenToolkit_authorName = "Michael D. Lowis"

