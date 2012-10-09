syn clear
"
" Motorola S-Record Syntax highlighting file
"

" Match the Record type field
syn match s0 /^S0/ nextgroup=count0
syn match s1 /^S1/ nextgroup=count1
syn match s2 /^S2/ nextgroup=count2
syn match s3 /^S3/ nextgroup=count3
syn match s5 /^S5/ nextgroup=count5
syn match s7 /^S7/ nextgroup=count7
syn match s8 /^S8/ nextgroup=count8
syn match s9 /^S9/ nextgroup=count9

" -----------------s0 -------------------------
" Match the count field
syn match count0 /\x\x/ nextgroup=address0
" Match the address field
syn match address0 /\x\{4\}/ nextgroup=crc

" ---------------- s1 --------------------------
" Match the count field
syn match count1 /\x\x/ nextgroup=address1
" Match the address field
syn match address1 /\x\{4\}/ nextgroup=body1

" ---------------- s2 --------------------------
" Match the count field
syn match count2 /\x\x/ nextgroup=address2
" Match the address field
syn match address2 /\x\{6\}/ nextgroup=body1

" ---------------- s3 --------------------------
" Match the count field
syn match count3 /\x\x/ nextgroup=address3
" Match the address field
syn match address3 /\x\{8\}/ nextgroup=body1

" ---------------- s5 --------------------------
" Match the count field
syn match count5 /\x\x/ nextgroup=address5
" Match the address field
syn match address5 /\x\{8\}/ nextgroup=crc

" ---------------- s7 --------------------------
" Match the count field
syn match count7 /\x\x/ nextgroup=address7
" Match the address field
syn match address7 /\x\{8\}/ nextgroup=crc

" ---------------- s8 --------------------------
" Match the count field
syn match count8 /\x\x/ nextgroup=address8
" Match the address field
syn match address8 /\x\{6\}/ nextgroup=crc

" ---------------- s9 --------------------------
" Match the count field
syn match count9 /\x\x/ nextgroup=address9
" Match the address field
syn match address9 /\x\{4\}/ nextgroup=crc

" ---------------- body and crc ----------------
syn match body1 /\x\{2}/ nextgroup=crc,body2
syn match body2 /\x\{2}/ nextgroup=crc,body1
syn match crc /\x\x\s*$/

hi def link s0       SpecialKey
hi def link count0   Special
hi def link address0 PreProc
hi def link s1       SpecialKey
hi def link count1   Special
hi def link address1 PreProc
hi def link s2       SpecialKey
hi def link count2   Special
hi def link address2 PreProc
hi def link s3       SpecialKey
hi def link count3   Special
hi def link address3 PreProc
hi def link s5       SpecialKey
hi def link count5   Special
hi def link address5 PreProc
hi def link s7       SpecialKey
hi def link count7   Special
hi def link address7 PreProc
hi def link s8       SpecialKey
hi def link count8   Special
hi def link address8 PreProc
hi def link s9       SpecialKey
hi def link count9   Special
hi def link address9 PreProc
hi def link body1    Normal
hi def link body2    Comment
hi def link crc      LineNr

