"==============================================================================
" Wish List
"==============================================================================
" Less buggy session restore
" Default window setup

"==============================================================================
" General Settings
"==============================================================================
syntax enable                    " Turn on syntax highlighting
filetype plugin indent off       " Turn off plugin indent to make indent follow previous line (This makes indenting consistent across filetypes)
colorscheme torte                " Set default color scheme
set nocompatible                 " Disable VI compatibility
set backspace=indent,eol,start   " Makes backspace work as expected
set whichwrap+=<,>,[,],h,l       " Make cursor keys wrap lines
set autoindent                   " Indent follows previous line
set tabstop=4                    " Tabs equivalent to 4 spaces
set shiftwidth=4                 " Sets the size used for vims reindent operator ( Shift-> and Shift-< )
set number                       " Turn on line numbering
set colorcolumn=80               " Draw right margin at 80 chars
set nowrap                       " Turn off line wrapping so long lines extend off screen
set foldmethod=syntax            " Enable folds defined by syntax (i.e. functions)
set foldlevelstart=100           " Open all folds by default
set so=7                         " scrolling activates at 7 lines from the top or bottom of screen
set ruler                        " Always show current cursor position
set showmatch                    " Highlight matching braces
set vb t_vb=                     " Turn off visual and error bells
set cursorline                   " Highlights current line
set hid                          " Change buffer without saving
set clipboard=unnamed            " Yank and Put commands use the system clipboard
set hlsearch                     " Turn on search higlighting
set laststatus=2                 " Turn on status line all the time
set ignorecase                   " Ignore case in searches

"==============================================================================
" More Complicated Settings
"==============================================================================
"---- Turn off backup and swap files ----
set nobackup
set nowb
set noswapfile

"---- OmniComplete ----
filetype plugin on
set ofu=syntaxcomplete#Complete
set completeopt=longest,menuone
highlight Pmenu guibg=blue gui=bold

"---- Wild Mode ----
set wildmenu                 " Turns on auto complete for vim command line
set wildmode=full

"---- Persistent Undo ----
set undodir=~/vimfiles/undo  " Set directory for storing undo files
set undofile                 " Turn on persistent undo

"---- CScope ----
set cscopetag                " Search both cscope dbs and ctags files for tags
set csto=0                   " Search cscope dbs before ctags files

"---- Make the Home and End keys smarter ----
noremap  <expr> <Home> (col('.') == matchend(getline('.'), '^\s*')+1 ? '0'  : '^')
noremap  <expr> <End>  (col('.') == match(getline('.'),    '\s*$')   ? '$'  : 'g_')
vnoremap <expr> <End>  (col('.') == match(getline('.'),    '\s*$')   ? '$h' : 'g_')
imap <Home> <C-o><Home>
imap <End>  <C-o><End>

"---- Save Session on Exit ----
augroup autosession
autocmd autosession BufRead,VimLeave * mksession! ~/.vimsession
function! RestoreSession()
	autocmd! autosession	
	source ~/.vimsession
	autocmd autosession BufRead,VimLeave * mksession! ~/.vimsession
endfunction

"---- Status Line ----
set statusline=\ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L\ \ Column:\ %c\ \ %F%m%r%h\ %w

"---- Change to Src dir when opened without a file ----
au VimEnter * if expand('%') == '' | cd C:\Src | endif 

"==============================================================================
" Functions
"==============================================================================
function! LoadCCTreeDB()
	CCTreeUnLoadDB
	let dir = GetCScopeDir() . "/cscope.out"
	execute("CCTreeLoadDB " . dir)
endfunction

function! CurDir()
    let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
    return curdir
endfunction

"==============================================================================
" Commands
"==============================================================================
" ---- Vimrc - Edit vimrc file ----
command! Vimrc :e ~/.vimrc

" ---- Print - Print the current file ----
command! Print :hardcopy

" ---- Split - Splits the selection into multiple lines based on whitespace ----
command! -range=% -nargs=0 Split execute "<line1>,<line2>s/\\s\\+/\r/g"

" ---- Trim - Trims trailing white space from the end of every line ----
command! -range=% -nargs=0 Trim execute "<line1>,<line2>s/\\s\\+$//"

" ---- ToSpaces - Converts leading tabs to spaces ----
command! -range=% -nargs=0 ToSpaces execute "<line1>,<line2>s/^\\t\\+/\\=substitute(submatch(0), '\\t', repeat(' ', ".&ts."), 'g')"

" ---- ToTabs - Converts leading spaces to tabs ----
command! -range=% -nargs=0 ToTabs execute "<line1>,<line2>s/^\\( \\{".&ts."\\}\\)\\+/\\=substitute(submatch(0), ' \\{".&ts."\\}', '\\t', 'g')"

" ---- Trim - Trims trailing white space from the end of every line ----
command! -range=% -nargs=0 NoCR execute "<line1>,<line2>s/\\r//"

" ---- Snippets - Opens a file browser in the snippets directory ----
command! Snippets :Ex $HOME/vimfiles/snippets

" ---- ToFns - Converts a group of C function prototypes to definitions ----
command! -range=% -nargs=0 ToFn execute "<line1>,<line2>s/;/\r{\r\r}\r/"

"==============================================================================
" Keyboard Mappings
"==============================================================================
" ---- Previous Buffer ----
map  <C-S-tab> :bp<CR>
imap <C-S-tab> <ESC>:bp<CR>

" ---- Next Buffer ----
map  <C-tab> :bn<CR>
imap <C-tab> <ESC>:bn<CR>

" ---- Delete Buffer (Keep Windows) ----
map  ;d :Kwbd<CR>

" ---- Directory Listing ----
map  ;o :Ex<CR>

" ---- List Buffers ----
map  ;bl :buffers<CR>:buffer

" ---- Restore Buffer ----
map  ;br :call BufferRestore()<CR>

" ---- Block Comment ----
map  ;cc <plug>NERDCommenterComment

" ---- Block Uncomment ----
map  ;cu <plug>NERDCommenterUncomment

" ---- Restore Previous Session ----
map  ;sr :call RestoreSession()<CR>

" ---- Toggle Fold ----
map  zz <ESC>za

" ---- Unindent Visual Block ----
vnoremap < <gv

" ---- Indent Visual Block ----
vnoremap > >gv

" ---- Swap current line with line below ----
nmap <C-j> ddp
imap <C-j> <ESC>ddpi

" ---- Swap current line with line above ----
nmap <C-k> ddkP
imap <C-k> <ESC>ddkPi

" ---- Update CTags file ----
map <F2> <ESC>:call RebuildTagsFile()<CR>

" ---- Update CScope Database ----
map <F3> <ESC>:call RebuildCScopeDB()<CR>

" ---- Open new file for editing ----
map <F4> <ESC>:enew<CR>i

" ---- Switch between header and C file ----
map <F5> <ESC>:e %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>

" ---- Fast File Open using CScope ----
map  ;f <ESC>:execute('cs find f ' . input('Filename: '))<CR>

" ---- Clear higlighting from last search ----
map  ;h <ESC>:nohl<CR>

" ---- Toggle NERD Tree side bar ----
map  ;t <ESC>:NERDTreeToggle<CR>

" ---- CScope Loader Mappings ----
" Find all references to token under cursor
map \fs <ESC>:CSFindS<CR>

" Find global definitions of token under cursor
map \fg <ESC>:CSFindG<CR>

" Find functions called by function under cursor
map \fd <ESC>:CSFindD<CR>

" Find functions calling function under cursor
map \fc <ESC>:CSFindC<CR>

" Find text under cursor
map \ft <ESC>:CSFindT<CR>

" Egrep for text under cursor
map \fe <ESC>:CSFindE<CR>

" Find file under cursor
map \ff <ESC>:CSFindF<CR>

" Find files including filename under cursor
map \fi <ESC>:CSFindI<CR>

" Load CScope database with CCTree plugin (for call tree generation)
map <C-\>l <ESC>:call LoadCCTreeDB()<CR>

"==============================================================================
" GVim
"==============================================================================
if has('gui_running')
	set guioptions-=T         " no toolbar
	set guioptions-=m         " no menubar
	set guioptions+=b         " enable horizontal tabbar
	set guifont=Monaco:h10    " use 10 point monaco font in gui mode

	" GVim resets this for some stupid reason so disable visual bell ... again
	autocmd GUIEnter * set visualbell t_vb=

	" GVim specific commands
	command! Menu   :set guioptions+=m
	command! NoMenu :set guioptions-=m
endif

