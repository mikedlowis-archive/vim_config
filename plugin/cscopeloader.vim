"==============================================================================
" Plugin: CScope Loader
"
" Description: This plugin attempts to find a cscope database corresponding to
" the current buffer and connect to it until the buffer is changed. The plugin
" searches from the containing folder up to the file system root looking for a
" cscope.out file. If a database is found it uses the cscope command to open a
" connection until the user changes to a different buffer.
"==============================================================================

"==============================================================================
" Global Variables
"==============================================================================
let s:RootPath = 'C:\'
let s:DirSeparator = '\'
let s:DBFileName = 'cscope.out'
let s:CScopeBin = 'cscope'
let s:CScopeOptions = '-Rb'

"==============================================================================
" Functions
"==============================================================================
function! GetCScopeDir()
	let searching = 1 
	let buf_path = '%:p'
	let cscope_dir = ''

	while searching
		let buf_path = buf_path . ':h'
		let search_path = expand(buf_path)
		let cscope_path = search_path . s:DirSeparator . s:DBFileName
		
		if tolower(search_path) == tolower(s:RootPath)
			let searching = 0
		endif

		if filereadable(cscope_path)
			let cscope_dir = search_path
			let searching = 0
		endif
	endwhile
	return cscope_dir 
endfunction

function! SetCScopeDB()
	let cscope_dir = GetCScopeDir()
	let cscope_file = cscope_dir . s:DirSeparator . s:DBFileName
	execute('cscope kill -1')
	if strlen(cscope_file)
		let cscope_file = escape( cscope_file, ' ')
		execute('cscope add ' . cscope_file . ' ' . cscope_dir . ' -C')
	endif
endfunction

function! RebuildCScopeDB()
	let prev_dir = getcwd()
	let cscope_dir = GetCScopeDir()
	echo cscope_dir
	if strlen(cscope_dir)
		execute('cscope kill -1')
		execute('cd ' . cscope_dir)
		execute('silent !' . s:CScopeBin . " " . s:CScopeOptions)
		call SetCScopeDB()
		execute('cd ' . prev_dir)
	endif
endfunction

"==============================================================================
" Commands
"==============================================================================
" Find all references to token
command! CSFindS :cs find s <cword><CR>

" Find global definitions of token
command! CSFindG :cs find g <cword><CR>

" Find all calls to function
command! CSFindD :cs find d <cword><CR>

" Find all instances of text
command! CSFindC :cs find c <cword><CR>

" egrep search for token
command! CSFindT :cs find t <cword><CR>

" Open filename
command! CSFindE :cs find e <cword><CR>

" Find files including filename
command! CSFindF :cs find f <cword><CR>

" Find functions that function calls
command! CSFindI :cs find i <cword><CR>

"==============================================================================
" Auto Commands
"==============================================================================
augroup cscopeloader
autocmd!
autocmd cscopeloader BufEnter * :call SetCScopeDB()

