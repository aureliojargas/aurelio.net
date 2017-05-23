" Arquivo: .vimrc
" Autor: Sérgio Luiz Araújo Silva - <voyeg3r@gmail.com>
" ultima modificação: Qui 01 Set 2005 13:02:46 BRT
" Download: http://aurelio.net/doc/vim/vimrc-voyeg3r.txt
" Licence: Licença: Este arquivo é de domínio público
" Garantia: O autor não se responsabiliza por eventuais danos
"           causados pelo uso deste arquivo.


"                  ( O O )
"	    ====oOO==(_)==OOo=====


" Linhas comentadas são iniciadas por (") aspas duplas


"""""""""""""""""""""""""""""""""""""""""""""""""
"                 S E T I N G S                 "
"""""""""""""""""""""""""""""""""""""""""""""""""



" By default, go for an indent of 4
set shiftwidth=4
set softtabstop=4
set viminfo=%,'50,\"100,:100,n
set undolevels=1000  " undoing 1000 changes should be enough :-)
set updatecount=100  " write swap file to disk after each 20 characters
set updatetime=6000  " write swap file to disk after 6 inactive seconds
set noerrorbells " don't make noise
set incsearch " habilita busca incremental
set ts=4 " Paradas de tabulação com 4 espaços
set nocompatible
set autowrite  "salvamento automático

"Word completion
"Complementação de palavras
set dictionary+=/usr/dict/words
set complete=.,w,k
set infercase
" make all windows the same size when adding/removing windows
set noequalalways

if has("gui_kde")
set guifont=Monospace/12/-1/5/50/0/0/0/0/0
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"      GUI SETINGS - CONFIGURAÇÕES GRÁFICAS

if has("gui_running")
" Le focus suit la souris
set mousef
" Le bouton droit affiche une popup
set mousemodel=popup_setpos
endif"

"============= Esquema de cores ====================
" a vantagem de manter um esquema de cores
" no próprio vimrc é que você fica independente
" de sistema, a definição de cores está no próprio vimr
"
" Vim color file
" Maintainer:	Hans Fugal <hans@fugal.net>
" Last Change:	$Date: 2003/05/06 16:37:49 $
" Last Change:	$Date: 2003/06/02 19:40:21 $
" URL:		http://hans.fugal.net/vim/colors/desert.vim
" Version:	$Id: desert.vim,v 1.6 2003/06/02 19:40:21 fugalh Exp $

" cool help screens
" :he group-name
" :he highlight-groups
" :he cterm-colors

set background=dark
if version > 580
" no guarantees for version 5.8 and below, but this makes it stop
" complaining
hi clear
if exists("syntax_on")
syntax reset
endif
endif
let g:colors_name="desert"

hi Normal	guifg=White guibg=grey20

" highlight groups
hi Cursor	guibg=khaki guifg=slategrey
"hi CursorIM
"hi Directory
"hi DiffAdd
"hi DiffChange
"hi DiffDelete
"hi DiffText
"hi ErrorMsg
hi VertSplit	guibg=#c2bfa5 guifg=grey50 gui=none
hi Folded	guibg=grey30 guifg=gold
hi FoldColumn	guibg=grey30 guifg=tan
hi IncSearch	guifg=slategrey guibg=khaki
"hi LineNr
hi ModeMsg	guifg=goldenrod
hi MoreMsg	guifg=SeaGreen
hi NonText	guifg=LightBlue guibg=grey30
hi Question	guifg=springgreen
hi Search	guibg=peru guifg=wheat
hi SpecialKey	guifg=yellowgreen
hi StatusLine	guibg=#c2bfa5 guifg=black gui=none
hi StatusLineNC	guibg=#c2bfa5 guifg=grey50 gui=none
hi Title	guifg=indianred
hi Visual	gui=none guifg=khaki guibg=olivedrab
"hi VisualNOS
hi WarningMsg	guifg=salmon
"hi WildMenu
"hi Menu
"hi Scrollbar
"hi Tooltip

" syntax highlighting groups
hi Comment	guifg=SkyBlue
hi Constant	guifg=#ffa0a0
hi Identifier	guifg=palegreen
hi Statement	guifg=khaki
hi PreProc	guifg=indianred
hi Type		guifg=darkkhaki
hi Special	guifg=navajowhite
"hi Underlined
hi Ignore	guifg=grey40
"hi Error
hi Todo		guifg=orangered guibg=yellow2

" color terminal definitions
hi SpecialKey	ctermfg=darkgreen
hi NonText	cterm=bold ctermfg=darkblue
hi Directory	ctermfg=darkcyan
hi ErrorMsg	cterm=bold ctermfg=7 ctermbg=1
hi IncSearch	cterm=NONE ctermfg=yellow ctermbg=green
hi Search	cterm=NONE ctermfg=grey ctermbg=blue
hi MoreMsg	ctermfg=darkgreen
hi ModeMsg	cterm=NONE ctermfg=brown
hi LineNr	ctermfg=3
hi Question	ctermfg=green
hi StatusLine	cterm=bold,reverse
hi StatusLineNC cterm=reverse
hi VertSplit	cterm=reverse
hi Title	ctermfg=5
hi Visual	cterm=reverse
hi VisualNOS	cterm=bold,underline
hi WarningMsg	ctermfg=1
hi WildMenu	ctermfg=0 ctermbg=3
hi Folded	ctermfg=darkgrey ctermbg=NONE
hi FoldColumn	ctermfg=darkgrey ctermbg=NONE
hi DiffAdd	ctermbg=4
hi DiffChange	ctermbg=5
hi DiffDelete	cterm=bold ctermfg=4 ctermbg=6
hi DiffText	cterm=bold ctermbg=1
hi Comment	ctermfg=darkcyan
hi Constant	ctermfg=brown
hi Special	ctermfg=5
hi Identifier	ctermfg=6
hi Statement	ctermfg=3
hi PreProc	ctermfg=5
hi Type		ctermfg=2
hi Underlined	cterm=underline ctermfg=5
hi Ignore	cterm=bold ctermfg=7
hi Ignore	ctermfg=darkgrey
hi Error	cterm=bold ctermfg=7 ctermbg=1


"====================================================

" se o sistema é um unix setar o terminal para bash
if has("unix")
let &shell="bash"
set clipboard=autoselect
" Let's be friendly :)
autocmd VimEnter * echo "Seja bem vindo ao vim. Seu sistema é Linux!"
else
autocmd VimEnter * echo "Seja bem vindo ao vim. Seu sistema é Windows!"
endif
"-----------------------------------------------------

" O trecho abaixo formata a barra de status com algumas opções
interessantes!
" mostra o código ascii do caractere sob o cursor e outras coisas mais
set statusline=%F%m%r%h%w\ [FORMATO=%{&ff}]\ [TIPO=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [linha=%04l,%04v][%p%%]\ [LINHAS=%L]
set laststatus=2 " Sempre exibe a barra de status


""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"          M A P E A M E N T O S
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""
" make search results appear in the middle of the screen
" faz os resultados da busca aparecerem no meio da tela
map n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

" Permite recarregar o vim para que modificações no
" próprio vimrc seja ativadas com o mesmo sendo editado
nmap <F12> :<C-u>source ~/.vimrc <BAR> echo "Vimrc recarregado!"<CR>
map ,u :source ~/.vimrc<CR>  " Para recarregar o .vimrc
map ,v :e ~\.vimrc<CR>  " para editar o .vimrc

" inserir linhas e continuar em modo normal
map ,o o<ESC>:echo<CR>
map ,O O<ESC>:echo<CR>

" copiar em modo visual
" possibilita colar em outra janela
vmap <F4> "+y

" Mover linhas com: Ctrl+(seta abaixo) ou (seta acima)
" tem que estar em modo normal!
map <C-Down> <esc>ddp<esc>
map <C-Up> <esc>ddkP<esc>

"Auto formatação para parágrafos
map <F8> gqap




" windows-style key mappings
" estilo de atalhos do windows
" copy - copiar
"vmap <C-C> y
" paste - colar
"nmap <C-V> p
"imap <C-V> <C-O>p
" cut - cortar
"vmap <C-X> x
" undo - desfazer
"noremap <C-Z> u
"inoremap <C-Z> <C-O>u
" select all - selecionar tudo
"map <C-a> <esc>ggvG
"

" ==============================================
"          seção para comandos latex
" ==============================================
" se você já tem alguma função para fechar parênteses
" apague no local  apropriado
"
" Fechamento automático de parênteses
imap { {}<left>
imap ( ()<left>
imap [ []<left>


" pular fora dos parênteses, colchetes e chaves
" na verdade caminha para a direita 'l' e para esquerda 'h'
imap <c-l> <esc><right>a
imap <c-h> <esc><left>a

" Break the current line after the cursor
nmap <F2> a<CR><Esc>

" as funções abaixo mudam se o fechamento de parênteses for modificado
" cria itemize
"map <F2> \begin{itemize<right><cr>\item{<right><cr>\end{itemize<esc>ki
"imap <F3>
\begin{enumerate<right><cr>\item{<right><cr>\end{enumerate<esc>ki
"imap <F4> \begin{center<right><cr><cr>\end{center<esc>ki
"imap <F5> \begin{verbatim<right><cr><cr><cr><cr>\end{verbatim<esc>kki
"imap <F6> \begin{document<right><cr><cr><cr>\end{document<esc>kki
"imap <c-t>
\begin{titlepage<right><cr><cr><cr><cr>\end{titlepage<esc>kk<F4>

"nmap <F2> i\begin{itemize<right><cr>\item{<right><cr>\end{itemize<esc>ki
"nmap <F3>
i\begin{enumerate<right><cr>\item{<right><cr>\end{enumerate<esc>ki
"nmap <F4> i\begin{center<right><cr><cr>\end{center<esc>ki
"nmap <F5> i\begin{verbatim<right><cr><cr><cr><cr>\end{verbatim<esc>kki
"nmap <c-t> i<c-t>


"remove espaços redundantes no fim das linhas
map <F7> <esc>mz:%s/\s\+$//g<cr>`z
"fiz uma adição ao comando depois do <esc> mz
"cria uma marca para voltar ao ponto em que se está
"e 'z retorna a este ponto ao final do comando


imap <F6> <c-n>
" Da a sequencia a essa palavra
imap <c-right> <c-x><c-n>
"
" Troca o case de maiúsculo para ...
map <C-M-u> <esc>~
imap <C-M-u> <esc>~

" negrito
"imap ,bf {\bf{
"nmap ,bf {\bf{
" paa criar um negrito selecione e use Ctrl+b
" itálico
"imap ,it {\it{
"nmap ,it i{\it{
" para criar um itálico selecione e use um Ctrl+i
" enfatizar
"imap ,em {\em{
"nmap ,em i{\em{
" chapter
"imap ,ch \chapter{
"nmap ,ch i\chapter{
" section
"imap ,se \section{
"nmap ,se i\section{
" máquina de escrever
"imap ,tt {\tt{
"nmap ,tt i{\tt{
" footnote
"imap ,fn \footnote{
"nmap ,fn i\footote{


" =================================================

" Redimensionar a janela com
" ALT+seta à direita e esquerda
map <M-right> <ESC>:resize +2 <CR>
map <M-left> <ESC>:resize -2 <CR>

" mudar de janelas
map <C-J> <C-W>j
map <C-k> <C-W>k

" ============== SPELL CHECK ===========
" Dicionario para procurar o auto-complemento de palavras
set dictionary=~/.dicionario/palavras.txt
" Completa uma palavra
" Da a sequencia a essa palavra
"imap <F8> <c-x><c-n>
" Procura no dicionario
"imap <c-d> <c-x><c-k>
" Passa um spell no arquivo
"map <F6> :!spell %<cr>
" Usando o ispell (ademar)
"map <F6> :!ispell -b %^M ^M^M :e ^M :new %.bak ^M <F4> gg
" Ispell no modo visual (miura)
":vmap <F12> <ESC>:w! $HOME/spell.tmp <ESC>:new <ESC>^W15-<ESC>:r
!spell $HOME/spell.tmp <ESC>^Wji<ESC>^Wr


let mapleader=","

",sn  próximo erro
",si insere a palavra no dicionário
",sa aceita a palavra
",sp erro anterior
",sq sai do corretor

map ,sc :SpellCheck <cr>
"map <S-F3> <esc>,sq
imap ,sc <esc>:SpellCheck <cr>
map ,pa :SpellProposeAlternatives<CR>
imap ,pa <esc>:SpellProposeAlternatives<CR>
map <C-M-Right> ,sn
map <C-M-Left> ,sp
map <C-M-a> ,sa
map <C-M-i> ,si
map <C-M-q> ,sq


"======================================
let spell_executable = "ispell"

"spell_case_accept_map                             
*spell_case_accept_map*
"This variable, if set, determines the mapping used to accept the word
"under the cursor, taking case into account. Defaults to: >
let spell_case_accept_map = "<Leader>si"

"When using 'ispell' the accepted words are put in the
"./.ispell_<language> file if it exists or in the
"$HOME/.ispell_<language> file.


"spell_accept_map                                       
*spell_accept_map*
"This variable, if set, determines the mapping used to accept a lowercase
"version of the word under the cursor. Defaults to: >
let spell_accept_map = "<Leader>su"


"spell_ignore_map                                       
*spell_ignore_map*
"This variable, if set, determines the mapping used to ignore the
"spelling error for the current session. Defaults to: >
let spell_ignore_map = "<Leader>sa"


"spell_next_error_map                               
*spell_next_error_map*
"This variable, if set, determines the mapping used to jump to the next
"spelling error. Defaults to: >
let spell_next_error_map = "<Leader>sn"


"spell_previous_error_map                       
*spell_previous_error_map*
"This variable, if set, determines the mapping used to jump to the
"previous spelling error. Defaults to: >
let spell_previous_error_map = "<Leader>sp"


"spell_exit_map                                           
*spell_exit_map*
"This variable, if set, determines the mapping used to exit from
"spelling-checker mode. Defaults to: >
let spell_exit_map = "<Leader>sq"

"======================================

let spell_auto_type="tex,doc,mail"
" não foi necessário setar a opção abaixo
au! BufNewFile,BufRead * let b:spell_language="brazilian"

"* highlighting schemes can be overridden:
"highlight default SpellErrors ctermfg=Green guifg=Green
"	  \ cterm=underline gui=underline term=reverse

highlight default SpellErrors ctermfg=Red guifg=Red
   \ cterm=underline gui=underline term=reverse



"====== complementação de palavras ====
"usa o tab em modo insert para completar palavras
function! InsertTabWrapper(direction)
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    elseif "backward" == a:direction
        return "\<c-p>"
    else
        return "\<c-n>"
    endif
endfunction

inoremap <tab> <c-r>=InsertTabWrapper ("forward")<cr>
inoremap <s-tab> <c-r>=InsertTabWrapper ("backward")<cr>


" ============== SPELL CHECK ===========
" o mapeamento abaixo coloca e retira a numeração
" o sistema alterna a numeração para ativa ou desativada
map <F11> <esc>:set nu!<cr>
map <S-F12> <esc>:dig<cr> " mostra os digrafos do tipo Word®
" mapeamento para salvar com CTRL+s
map <C-S> :w<CR>
imap <C-S> <C-O><C-S>
cmap <C-S> <C-C><C-S>

" salva com F9
nmap <F9> <esc>:w<cr>
imap <F9> <C-O><C-S>
" salva com <F10> e sai do vim
nmap <F10> <esc>:q<cr>


" Affiche la date au format RFC822 - ftplugin/debchangelog. Nico
function! Date822()
    let savelang = v:lc_time
    execute "language time C"
    let dateandtime = strftime("%a, %d %b %Y %X %z")
    execute "language time " . savelang
    return dateandtime
endfunction
iab debdate <C-R>=Date822()<CR>

" Mapeamento para apagar com Backspace
map <BS> X

"-----------------------------------------------------
" oculta o destaque das buscas, e exibe de novo com shift+F11
" tira as cores das ocorrências de busca e recoloca (booleano)
nno <S-F11> :set hls!<bar>set hls?<CR>


" seta: numeração, indentação expansão de tab para espaços
" mostra fechamento de parêntese, mostra régua, modo em que
" está etc.
set nu ai et sm js
set showcmd showmode
set ruler
set backup
set backupdir=~/.vim/backup
syntax enable


highlight PALAVRAS ctermbg=red
syntax keyword PALAVRAS linux Nota nota

"-----------------------------------------------------
" Destaca espaços e tabs redundantes
" caso queira usar descomente as ultimas linha e reinicie o
" vim ou pressione ,u caso etnha a função de recarregar (veja linha17)
" Highlight redundant whitespace and tabs.
highlight RedundantWhitespace ctermbg=red guibg=red
match RedundantWhitespace /\s\+$\| \+\ze\t/

" for txt, autoformat and wrap text at 70 chars.
autocmd BufNewFile,BufRead *.txt set wrapmargin=70 textwidth=70


" Habilita a detecção do tipo de arquivo
" Enable file type detection
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" autocomando para arquivos html, xml e xsl para fechar tagas
" pode ser encontrado em:
" http://vim.sourceforge.net/scripts/script.php?script_id=13
" autocmd FileType html,xml,xsl source ~/docs/vim/closetag.vim

" descomente a linha acima caso tenha o arquivo indicado

"-----------------------------------------------------
" dá permissão para arquivos dos tipos descritos abaixo
" Automatically give executable permissions if filename ends in .sh, .pl or .cgi
au BufWritePost *.sh,*.pl,*.cgi :!chmod a+x <afile>
"-----------------------------------------------------
" Automatically give executable permission to scripts starting
  " with #!/usr/bin/perl and #!/bin/sh
  au BufWritePost * if getline(1) =~ "^#!/bin/[a-z]*sh" ||
              \ getline(1) =~ "^#!/usr/bin/perl" | silent execute
"!chmod a+x <afile>" | endif

"----------------- Abreviações --------------------
" abreviatura para o meu nome
iab tambem também
iab teh the
iab latex \LaTeX\
iab ,m <voyeg3r@gmail.com>
ab slas Sérgio Luiz Araújo Silva
ab vc você
iab teh the
iab a. ª
iab analize análise
iab angulo ângulo
iab apos após
iab apra para
iab aqeule aquele
iab aqiulo aquilo
iab arcoíris arco-íris
iab aré até
iab asim assim
iab aspeto aspecto
iab assenção ascenção
iab assin assim
iab assougue açougue
iab aue que
iab augum algum
iab augun algum
iab ben bem
iab beringela berinjela
iab bon bom
iab cafe café
iab caichote caixote
iab capitões capitães
iab cidadães cidadãos
iab ckaro claro
iab cliche clichê
iab compreenssão compreensão
iab comprensão compreensão
iab comun comum
iab con com
iab contezto contexto
iab corrijir corrigir
iab coxixar cochichar
iab cpm com
iab cppara para
iab dai daí
iab danca dança
iab decer descer
iab definitamente definitivamente
iab deshonestidade desonestidade
iab deshonesto desonesto
iab detale detalhe
iab deven devem
iab díficil difícil
iab distingeu distingue
iab dsa das
iab dze dez
iab ecessão exceção
iab ecessões exceções
iab eentão e então
iab emb bem
iab ems sem
iab emu meu
iab en em
iab enbora embora
iab equ que
iab ero erro
iab erv ver
iab ese esse
iab esselência excelência
iab esu seu
iab excessão exceção
iab Excesões exceções
iab excurção excursão
iab Exenplo exemplo
iab exeplo exemplo
iab exijência exigência
iab exijir exigir
iab expontâneo espontâneo
iab ezemplo exemplo
iab ezercício exercício
iab faciu fácil
iab fas faz
iab fente gente
iab ferias férias
iab geito jeito
iab gibóia jibóia
iab gipe jipe
iab ha há
iab hezitação hesitação
iab hezitar hesitar
iab http:\\ http:
iab iigor igor
iab interesado interessado
iab interese interesse
iab Irria Iria
iab iso isso
iab isot isto
iab ítens itens
iab ja já
iab jente gente
iab linguiça lingüiça
iab linux GNU/Linux
iab masi mais
iab maz mas
iab con com
iab mema mesma
iab mes mês
iab muinto muito
iab nao não
iab nehum nenhum
iab nenina menina
iab noã não
iab no. nº
iab N. Nº
iab o. º
iab obiter obter
iab observacao observação
iab ons nos
iab orijem origem
iab ospital hospital
iab poden podem
iab portugu6es português
iab potuguês português
iab precisan precisam
iab própio próprio
iab quado quando
iab quiz quis
iab recizão rescisão
iab sanque sangue
iab sao são
iab sen sem
iab sensivel sensível
iab sequéncia seqüência
iab significatimente significativam
iab sinceranete sinceramente
iab sovre sobre
iab susseder suceder
iab tanbem também
iab testo texto
iab téxtil têxtil
iab tydo tudo
iab una uma
iab unico único
iab utilise utilize
iab vega veja
iab vja veja
iab voc6e você
iab wue que
iab xave chave

iab 1a. 1ª
iab 2a. 2ª
iab 3a. 3ª
iab 4a. 4ª
iab 5a. 5ª
iab 6a. 6ª
iab 7a. 7ª
iab 8a. 8ª
iab 9a. 9ª
iab 10a. 10ª
iab 11a. 11ª
iab 12a. 12ª
iab 13a. 13ª
iab 14a. 14ª
iab 15a. 15ª



"coloca a data tipo Ter 26/Out/2004 hs 10:53 na linha atual
iab ,d <C-R>=strftime("%a %d/%b/%Y hs %H:%M")<CR>
iab ,m <voyeg3r@gmail.com>

" a função (strftime) é predefinida pelo sistema
iab YDATE <C-R>=strftime("%a %d/%b/%Y hs %H:%M")<CR>
iab HDATE <C-R>=strftime("%a %d/%b/%Y hs %H:%M")<CR>
" Example: 1998-11-05 19:20:43 MST

" Estas linhas sao para não dar erro
" na hora de salvar arquivos
cab W  w
cab Wq wq
cab wQ wq
cab WQ wq
cab Q  q


" ===========================================
" Função para pular para uma linha qualquer
" ir para linha
" ir para uma linha expecífica
function! GoToLine()
let ln = inputdialog("ir para a linha...")
exe ":" . ln
endfunction
"no meu caso o mapeamento é com Alt-l
"use o que melhor lhe convier
imap <M-l> <C-o>:call GoToLine()<CR>
nmap <M-l> :call GoToLine()<CR>
" ===========================================


" =============== DATA AUTOMÁTICA ===========================
" insira na em seus arquivos =   "ultima modificação:"
" em qualquer das três primeiras linhas
fun! SetDate()
   mark z
   if getline(1) =~ ".*ultima modificação:" ||
                           \ getline(2) =~ ".*ultima modificação:"  ||
                           \ getline(3) =~ ".*ultima modificação:"  ||
                           \ getline(4) =~ ".*ultima modificação:"  ||
                           \ getline(5) =~ ".*ultima modificação:"
      exec "1,5s/\s*ultima modificação: .*$/ultima modificação: " .
strftime("%c") . "/"
   endif
   exec "'z"
endfun

"  abaixo a chamada a função de data que é chamada toda vez que você
"  salva um arquivo preexistente

fun! LastChange()
   mark z
   if getline(1) =~ ".*Last Change:" ||
                           \ getline(2) =~ ".*Last Change:"  ||
                           \ getline(3) =~ ".*Last Change:"  ||
                           \ getline(4) =~ ".*Last Change:"  ||
                           \ getline(5) =~ ".*Last Change:"
      exec "1,5s/\s*Last Change: .*$/Last Change: " . strftime("%c") . "/"
   endif
   exec "'z"
endfun
" coloquei duas opções (alteração e modificação), assim
" não tem perigo de você esquecer e o sistema
" não atualizar a data do salvamento, outra melhoria na função
" é que agora é válida para qualquer tipo de arquivo. se usar
" num html por exemplo insira um começo de comentário na linha
" da data e feche o comentário na próxima linha

"  abaixo a chamada a função de data que é chamada toda vez que você
"  salva um arquivo preexistente

au BufWritePre * call SetDate()
au BufWritePre * call LastChange()

"============ Fim da Data Automática ===================

" === Cria um registro de alterações de arquivo ========
" ChangeLog entry convenience
" Função para inserir um status do arquivo
" cirado: data de criação, alteração, autor etc
fun! InsertChangeLog()
    normal(1G)
    call append(0, "Arquivo")
    call append(1, "Criado: " . strftime("%a %d/%b/%Y hs %H:%M"))
    call append(2, "ultima modificação: " . strftime("%a %d/%b/%Y hs %H:%M"))
    call append(3, "Autor: Sérgio Luiz Araújo Silva - voyeg3r@gmail.com")
    normal($)
endfun
map ,cl :call InsertChangeLog()<cr>A

" Cria um cabeçalho para scripts bash
fun! InsertHeadBash()
    normal(1G)
    call append(0, "#!bin/bash")
    call append(1, "# Criado em:" . strftime("%a %d/%b/%Y hs %H:%M"))
    call append(2, "# ultima modificação:" . strftime("%a %d/%b/%Y hs %H:%M"))
    call append(3, "# Departamento Estadual de Trânsito - DETRAN/CE")
    call append(3, "# Propósito do script")
    normal($)
endfun
map ,sh :call InsertHeadBash()<cr>A



" Remove Ctrl+M do final de linhas do DOS
" get rid of
if has("user_commands")
  " remove ^M from the file
  com! RemoveCtrlM :%s/^M/\r/g
  " change to directory of current file
  com! CD cd %:p:h
endif

"-----------------------------------------------------
" HTML: Funcoes particulares para editar arquivos HTML
" Cria um esqueleto de arquivo HTML ao abrir um arquivo novo .html
" Should stop HTML Files auto-indenting

"-----------------------------------------------------
"augroup html
" au! <--> Remove all html autocommands
"  au!
"  au BufNewFile,BufRead *.html,*.shtml,*.htm set ft=html
"  au BufNewFile,BufRead,BufEnter  *.html,*.shtml,*.htm so ~/docs/vim/.vimrc-html
"  au BufNewFile *.html 0r ~/docs/vim/skel.html
"  au BufNewFile *.html*.shtml,*.htm /body/+
"  au BufNewFile,BufRead *.html,*.shtml,*.htm set noautoindent
"augroup end
"-----------------------------------------------------

"-----------------------------------------------------
" Procure usar a função "InsertHeadBash()" com o mesmo propósito
" das linhas abaixo. A função citada insere um cabeçalho pronto
" com "change log".
" autocomandos para scripts
"augroup sh
"        au!
"        au BufNewFile *.sh 0r ~/docs/vim/skel.sh
"        au BufNewFile,BufRead *.sh set ts=4
"augroup end

"-----------------------------------------------------
" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
"
" Ao editar um arquivo será aberto no ultimo ponto em
" que foi editado
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
"
