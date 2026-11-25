" Vim syntax file
" Language:     Oat
" Maintainer:   Timo Früh <dev@tifrueh.ch>
" Remark:       A /very/ simple VIM Syntax file for the OAT (v1/v2) as defined
"               in the Compiler Design course at ETHZ (approximately).

" Add to keyword symbols.
setlocal iskeyword+=?
setlocal iskeyword+=|
setlocal iskeyword+=&
setlocal iskeyword+=[
setlocal iskeyword+=]
setlocal iskeyword+=!
setlocal iskeyword+=<
setlocal iskeyword+=>
setlocal iskeyword+==
setlocal iskeyword+=-
setlocal iskeyword+=*
setlocal iskeyword+=+
setlocal iskeyword+=~
setlocal iskeyword+=.

" Set case sensitivity.
syntax case match

" Define reserved keywords.
syntax keyword oatStruct      struct
syntax keyword oatNull        null
syntax keyword oatTVoid       void
syntax keyword oatTString     string
syntax keyword oatTBool       bool
syntax keyword oatTInt        int
syntax keyword oatElse        else
syntax keyword oatIf          if
syntax keyword oatIfQ         if?
syntax keyword oatWhile       while
syntax keyword oatReturn      return
syntax keyword oatVar         var
syntax keyword oatGlobal      global
syntax keyword oatLength      length
syntax keyword oatFor         for
syntax keyword oatNew         new
syntax keyword oatTrue        true
syntax keyword oatFalse       false

" Define operator keywords.
syntax keyword oatGtGtGt      >>>
syntax keyword oatArrow       ->
syntax keyword oatLtlt        <<
syntax keyword oatGtGt        >>
syntax keyword oatBangEq      !=
syntax keyword oatLtEq        <=
syntax keyword oatLt          <
syntax keyword oatGtEq        >=
syntax keyword oatEqEq        ==
syntax keyword oatPlus        +
syntax keyword oatDash        -
syntax keyword oatStar        *
syntax keyword oatGt          >

" Define matchings.
syntax match   oatInt         /0x\x\+\|\d\+/
syntax match   oatLineComment /#.*/
syntax match   oatIAnd        /\[&\]/
syntax match   oatIOr         /\[|\]/
syntax match   oatBar         /|/
syntax match   oatAmper       /&/

" Define regions.
syntax region  oatString      start=/"/ skip=/\\"/ end=/"/
syntax region  oatComment     start=/\/\*/ end=/\*\// contains=oatComment

" Link to highlight groups.
hi def link    oatStruct      Type
hi def link    oatNull        Special
hi def link    oatTVoid       Type
hi def link    oatTString     Type
hi def link    oatTBool       Type
hi def link    oatTInt        Type
hi def link    oatElse        Conditional
hi def link    oatIf          Conditional
hi def link    oatIfQ         Conditional
hi def link    oatWhile       Repeat
hi def link    oatReturn      Keyword
hi def link    oatVar         Keyword
hi def link    oatGlobal      Keyword
hi def link    oatLength      Operator
hi def link    oatFor         Repeat
hi def link    oatNew         Keyword
hi def link    oatTrue        Boolean
hi def link    oatFalse       Boolean
hi def link    oatGtGtGt      Operator
hi def link    oatArrow       Operator
hi def link    oatLtlt        Operator
hi def link    oatGtGt        Operator
hi def link    oatBangEq      Operator
hi def link    oatLtEq        Operator
hi def link    oatLt          Operator
hi def link    oatGtEq        Operator
hi def link    oatEqEq        Operator
hi def link    oatPlus        Operator
hi def link    oatDash        Operator
hi def link    oatStar        Operator
hi def link    oatGt          Operator
hi def link    oatBar         Operator
hi def link    oatAmper       Operator
hi def link    oatIAnd        Operator
hi def link    oatIOr         Operator
hi def link    oatIdent       Identifier
hi def link    oatInt         Number
hi def link    oatLineComment Comment
hi def link    oatString      String
hi def link    oatComment     Comment
