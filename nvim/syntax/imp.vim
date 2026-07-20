" A /very/ simple VIM Syntax file for the language IMP as defined in the
" course FMFP at ETHZ (approximately).

" Set case sensitivity.
syntax case match

" Define basic keywords.
syntax keyword impStatement skip
syntax keyword impIf if then else end
syntax keyword impWhile while do end

" Define matches.
syntax match   impIdentifier /\a\+/
syntax match   impNumber /\d\+/
syntax match   impAssign /\a\+:=\a\+/

" Link to standard group names.
highlight link impIdentifier Identifier
highlight link impStatement Statement
highlight link impIf Conditional
highlight link impWhile Repeat
highlight link impNumber Number
