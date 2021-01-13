if exists("b:current_syntax")
  finish
endif

syn match lirBookmarkDirectory "^.*\/$"

hi def link lirBookmarkDirectory PreProc

let b:current_syntax = 'lir_bookmark'
