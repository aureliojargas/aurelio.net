" Vim syntax file
" Filename:	qzz.vim
" Language:	plain text
" Maintainer:	aurélio marinho jargas aurelio@verde666.org
" Last change:	qui jan 11 00:47:52 EST 2001
"coloque em seu ~/.vimrc:
" au BufNewFile,BufRead ~/path/to/book/* so ~/path/to/qzz.vim
"
set tw=0

syn match qzzTips      '^\* [^ ].*'
syn match qzzQuestion  '^[^ .,;*].*'
syn match qzzString     '^  [^ ]'me=e-1
syn match qzzIcString   '^, [^ ]'me=e-1
syn match qzzRegex     '^\. [^ ]'me=e-1
syn match qzzIcRegex    '^; [^ ]'me=e-1
syn match qzzComment   '^#.*'

" color definitions
hi qzzComment  ctermfg=lightcyan
hi qzzTips     ctermfg=yellow
hi qzzQuestion ctermfg=darkcyan
hi qzzString   ctermfg=black ctermbg=white
hi qzzIcString ctermfg=black ctermbg=red
hi qzzRegex    ctermfg=black ctermbg=blue
hi qzzIcRegex  ctermfg=black ctermbg=magenta


let b:current_syntax = 'qzz'
