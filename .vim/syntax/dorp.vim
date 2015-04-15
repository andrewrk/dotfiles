" Vim syntax file
" Language: dorp

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case match


" keywords
syn keyword dorpKeyword def var
syn keyword dorpKeyword if then else
syn keyword dorpKeyword throw try catch as
syn keyword dorpKeyword break continue return

" atoms
syn match   dorpNumber /-\?\<\d\+\>/
syn match   dorpNumber  /\<0x\x\+\>/
syn match   dorpFloat  /-\?\<\d\+\.\d*\(e[+-]\d\+\)\?\>/
syn keyword dorpBoolean true false
syn region  dorpString start=/"/ skip=/\\"/ end=/"/ contains=dorpEscape,dorpEscapeError
syn match   dorpEscape +\\[n"\\]+ contained
syn match   dorpEscape "\\x\x\{2}" contained
syn match   dorpEscapeError +\\[^n"\\x]+ contained
syn match   dorpIdentifier /[a-z_][a-zA-Z_0-9]*/
syn match   dorpType /[A-Z][a-zA-Z_0-9]*/

" comments and whitespace
syn match   dorpComment /#.*$/ contains=dorpCommentError
syn match   dorpCommentError display excludenl " \+$" contained
syn match   dorpError display excludenl " \+$"
syn match   dorpError "\t"

" what the categories mean
hi def link dorpType Type
hi def link dorpNumber Number
hi def link dorpComment Comment
hi def link dorpCommentError Error
hi def link dorpString String
hi def link dorpEscape Special
hi def link dorpEscapeError Error
hi def link dorpKeyword Keyword
hi def link dorpBoolean Boolean
hi def link dorpFloat Float
hi def link dorpIdentifier Identifier
hi def link dorpError Error

let b:current_syntax = "dorp"
