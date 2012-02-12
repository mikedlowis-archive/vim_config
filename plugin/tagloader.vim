"==============================================================================
" Plugin: Tag Loader
"
" Description: This plugin will search for a tags file in every directory from
" the containing directory of the file in the current buffer, up to the
" filesystem root. When a tags file is found the tags option is set to the 
" directory containing the tag file. If a tags file is not found, the tags
" option is set to the current directory.
"==============================================================================

"==============================================================================
" Global Variables
"==============================================================================
let s:RootPath = 'C:\'
let s:DirSeparator = '\'
let s:TagsFileName = 'tags'
let s:CTagsBin = 'ctags'
let s:CTagsOptions = '-R'

"==============================================================================
" Functions
"==============================================================================
function! s:GetTagsFileDir()
	let searching = 1 
	let buf_path = '%:p'
	let tags_dir = ''

	while searching
		let buf_path = buf_path . ':h'
		let search_path = expand(buf_path)
		let tag_path = search_path . s:DirSeparator . s:TagsFileName
		
		if tolower(search_path) == tolower(s:RootPath)
			let searching = 0
		endif

		if filereadable(tag_path)
			let tags_dir = search_path
			let searching = 0
		endif
	endwhile
	return tags_dir 
endfunction

function! SetTagsFile()
	let tags_file = s:GetTagsFileDir()
	if strlen(tags_file)
		let tags_file = tags_file . s:DirSeparator . s:TagsFileName
	endif
	let tags_file = escape( tags_file, ' ')
	execute('set tags='.tags_file)
endfunction

function! RebuildTagsFile()
	let prev_dir = getcwd()
	let tags_dir = s:GetTagsFileDir()
	if strlen(tags_dir)
		execute("cd ".tags_dir)
		execute('silent !' . s:CTagsBin . " " . s:CTagsOptions)	
		let tags_file = tags_dir . s:DirSeparator . s:TagsFileName
		let tags_file = escape(tags_file , ' ')
		execute('set tags=' . tags_file)
		execute('cd '.prev_dir)
	endif
endfunction

"==============================================================================
" Auto Commands
"==============================================================================
augroup tagsloader
autocmd!
autocmd tagsloader BufEnter * :call SetTagsFile()

