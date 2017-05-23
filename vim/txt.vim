" Vim syntax file
" Filename: txt.vim
" Language: plain text :)
" Maintainer: Aurelio Marinho Jargas
" URL: http://aurelio.net/vim/txt.vim
" Instalacao: Colocar no final do seu ~/.vimrc:
"   au BufNewFile,BufRead *.txt source ~/rota/para/txt.vim
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syn clear
syn case ignore

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"MISC:
syn keyword txtTodo    TODO FIXME XXX contained
syn match   txtComment '^#.*$' contains=txtTodo
syn match   txtNumber  '\<\d\+\([,.]\d\+\)\{,1}\>'
syn match   txtPercent '\<\d\+\([,.]\d\+\)\{,1}%'
"syn match   txtBlank   '\s\+$'
syn match   txtBar     '^\s*[_=-]\{20,}\s*$'
syn match   txtSpecial '[][(){}®]'
syn match   txtSpecial '\<\(US\|R\)\$'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"URL EMAIL:
syn match txtEmail '\<[A-Za-z0-9_.-]\+@\([A-Za-z0-9_-]\+\.\)\+[A-Za-z]\{2,4}\>\(?[A-Za-z0-9%&=+.,@*_-]\+\)\='
syn match txtUrl   '\<\(\(https\=\|ftp\|news\|telnet\|gopher\|wais\)://\([A-Za-z0-9._-]\+\(:[^ @]*\)\=@\)\=\|\(www[23]\=\.\|ftp\.\)\)[A-Za-z0-9%._/~:,=$@-]\+\>/*\(?[A-Za-z0-9/%&=+.,@*_-]\+\)\=\(#[A-Za-z0-9%._-]\+\)\='
syn match txtEmailMsg '^\s*\(From\|De\|To\|Para\|Date\|Data\|Assunto\|Subject\):.*'
syn match txtEmailQuote '^\(>\($\| \)\)\+'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"LIST:
syn match txtList    '^ *[-+*.] [^ ]'me=e-1
syn match txtList    '^ *[0-9]\+) '
syn match txtDefList '^ *[^:]\{6,\}:'hs=e contains=ALL

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"FONT BEAUTIFIERS:
syn match   txtUnderline  '_[^_[:blank:]].\{-}_'hs=s+1,he=e-1
syn match   txtBold       '\*[^*[:blank:]].\{-}\*'hs=s+1,he=e-1
syn match   txtMonospace  "`[^`]\+`"hs=s+1,he=e-1
" max: two lines
syn match   txtParentesis "([^)]\+\(\n\)\=[^)]*)" contains=txtUrl,txtEmail
syn match   txtQuotes     '"[^"]\+\(\n\)\=[^"]*"'hs=s+1,he=e-1
" max: two words
syn match   txtQuotes     "'\w\+ \?\w\+'"hs=s+1,he=e-1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" color definitions (specific)
hi txtBar         term=bold        cterm=bold        gui=bold
hi txtBold        term=bold        cterm=bold        gui=bold
hi txtItalic      term=italic      cterm=italic      gui=italic
hi txtUnderline   term=underline   cterm=underline   gui=underline
"
" color definitions (using Vim defaults)
hi link txtComment      Comment
hi link txtQuotes       String
hi link txtBlank        Error
hi link txtNumber       Number
hi link txtPercent      Number
hi link txtTodo         Todo
hi link txtEmail        PreProc
hi link txtUrl          PreProc
hi link txtList         Statement
hi link txtDefList      Statement
hi link txtMonospace    Special
hi link txtSpecial      Statement
hi link txtParentesis   Comment
hi link txtEmailMsg     Structure
hi link txtEmailQuote   Structure
"
let b:current_syntax = 'txt'
" vim:tw=0:et
