"==============================================================================
" General Settings
"==============================================================================
syntax enable                    " Turn on syntax highlighting
filetype plugin indent off       " Turn off plugin indent to use custom indent settings
colorscheme torte                " Set default color scheme
set nocompatible                 " Disable VI compatibility
set backspace=indent,eol,start   " Makes backspace work as expected
set whichwrap+=<,>,[,],h,l       " Make cursor keys wrap line
set autoindent                   " turn on auto indent
set copyindent                   " Indent follows previous line
set tabstop=4                    " Tabs equivalent to 4 spaces
set shiftwidth=4                 " Sets the size used for Vim's re-indent operator ( Shift-> and Shift-< )
set expandtab                    " Expand tabs to spaces
set softtabstop=4                " Backspace over expanded tabs
set number                       " Turn on line numbering
set colorcolumn=80               " Draw right margin at 80 chars
set nowrap                       " Turn off line wrapping so long lines extend off screen
set foldmethod=syntax            " Enable folds defined by syntax (i.e. functions)
set foldlevelstart=100           " Open all folds by default
set so=5                         " scrolling activates at 7 lines from the top or bottom of screen
set nobackup                     " Do not create backup files before editing
set nowritebackup                " Do not create backup files before writing
set noswapfile                   " Do not create a swap file for files before editing
set ruler                        " Always show current cursor position
set showmatch                    " Highlight matching braces
set mat=2                        " How long to blink matching braces for
set visualbell t_vb=             " Turn off visual and error bells
set noerrorbells                 " Turn off auditory bells
set hid                          " Change buffer without saving
set clipboard=unnamed            " Yank and Put commands use the system clipboard
set laststatus=0                 " Turn off the status line
set undodir=~/vimfiles/undo      " Set directory for storing undo files
set undofile                     " Turn on persistent undo
set cscopetag                    " Search both cscope dbs and ctags files for tags
set csto=0                       " Search cscope dbs before ctags files
set history=20                   " Save 20 lines of command history
set hlsearch                     " Turn on search highlighting
set ignorecase                   " Ignore case in searches
set smartcase                    " Don't ignore case when search term contains capitals
set incsearch                    " Highlight search string as you type
set tags=tags;/                  " Search from current directory to root for ctags db
set fileformats=unix,dos,mac     " support all three, in this order
set list                         " Show control and whitespace characters (tabs, spaces, etc.)
set listchars=tab:>-,trail:-     " Show only trailing spaces and tabs
set lazyredraw                   " Don't redraw unless we need to
set formatoptions+=r             " Enable continuation of comments after a newline

filetype plugin on
set omnifunc=syntaxcomplete#Complete
set completeopt=menu,preview

"==============================================================================
" Function and Command Definitions
"==============================================================================
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

function! ReformatWhiteSpace()
    if &modifiable
        retab
        silent! exec("%s/\\s\\+$//")
    endif
endfunction

" ---- ToFn - Converts a group of C function prototypes to definitions ----
command! -range=% -nargs=0 ToFn execute "<line1>,<line2>s/;/\r{\r\r}\r/"

"==============================================================================
" Keyboard Mappings
"==============================================================================
" ---- Define Map Leader ----
let mapleader = ";"
let g:mapleader = ";"

" ---- Quick Save ----
map <Leader>w :w<CR>

" ---- Toggle Fold ----
map  zz <ESC>za

" ---- Indenting Visual Blocks ----
vnoremap < <gv
vnoremap > >gv

" ---- Clear Search Highlighting ----
map <Leader>h :nohl<CR>

" ---- Omni Complete ----
inoremap <C-Space> <C-n>

" ---- Nerd Tree Toggle ----
map <Leader>t :NERDTreeToggle<CR>

" ---- Buffer Management ----
map  <C-S-tab>  :bp<CR>
imap <C-S-tab>  <ESC>:bp<CR>
map  <C-tab>    :bn<CR>
imap <C-tab>    <ESC>:bn<CR>
map  <Leader>d  :Kwbd<CR>
imap <Leader>d  <ESC>:Kwbd<CR>

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

" ---- Switch between header and C file ----
map <F5> <ESC>:e %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>

"==============================================================================
" Abbreviations
"==============================================================================
" Normal mode abbreviations
abbreviate inc #include
abbreviate def #define
abbreviate ifdef #ifdef<CR>#endif<up><END>
abbreviate ifndef #ifndef<CR>#endif<up><END>
abbreviate prf printf("");<left><left><left>

" Command mode abbreviations
cnoreabbrev trim %s/\s\+$//
cnoreabbrev print hardcopy
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

"==============================================================================
" GVim
"==============================================================================
if has('gui_running')
    set guioptions-=T         " no toolbar
    set guioptions-=m         " no menubar
    set guifont=Monaco:h10    " use 10 point Monaco font in gui mode

    " GVim resets this for some stupid reason so disable visual bell ... again
    autocmd GUIEnter * set visualbell t_vb=
endif