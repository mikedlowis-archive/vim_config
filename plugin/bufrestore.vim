"==============================================================================
" Plugin: Buffer Restore
"
" Description: This plugin keeps a stack of recently closed buffers and allows
" the user to pop a file off of the stack at any time and restore that file
" for editing. 
"==============================================================================

"==============================================================================
" Global Variables
"==============================================================================
let s:Recent_Files = []

"==============================================================================
" Functions
"==============================================================================
function! StoreBufferFilename(path)
	let buffer_name = a:path
	if !empty(buffer_name)
		let s:Recent_Files = [buffer_name] + s:Recent_Files
	endif
endfunction

function! BufferRestore()
	if len(s:Recent_Files) > 0
		let edit_command = ":edit " . s:Recent_Files[0]
		let s:Recent_Files = s:Recent_Files[1:]
		exec edit_command
	endif
endfunction

"==============================================================================
" Auto Commands
"==============================================================================
augroup bufrestore
autocmd!
autocmd bufrestore BufDelete * :call StoreBufferFilename(expand("<afile>"))

