" ****************************************************************************
" *  University: Universidade Federal Do Rio de Janeiro                      *
" *  Department: Departamento De Eletrônica e Computação Del - UFRJ          *
" *      Author: Ivan Carlos Da Silva Lopes                                  *
" *        Mail: <ivanczar78@yahoo.com.br, ivan.carlos78@gmail.com>          *
" *         Url: <URL:http://www.del.ufrj.br/~ivanczar>                      *
" * ------------------------------------------------------------------------ *
" *        File: .vimrc                                                      *
" *     License: GPL                                                         *
" *     Version: 1.0                                                         *
" *     Created: 10.03.2002  09:27:44                                        *
" * Last Update: 17.01.2005  03:08:32                                        *
" *Requirements: $/Home/data folder with  configuration files                *
" *Installation: - As dotfile drop the file into your $HOME/ folder.         *
" *              - In Command line put $vim -U .vimrc.                       *
" *                                                                          *
" ****************************************************************************
"                               _
"                        __   _(_)_ __ ___  _ __ ___
"                        \ \ / / | '_ ` _ \| '__/ __|
"                         \ V /| | | | | | | | | (__
"                      (_) \_/ |_|_| |_| |_|_|  \___|
"                                                          $ figlet -c .vimrc
"
"
"LEIAME sobre .vimrc (Versão 1.0) / 23.01.2005  03:17:28
"
"                       I N D I C E
"---------------------------------------------------------------
"
" *47       -  INTRODUCAO
" *93       -  INSTALACAO
" *228      -  CONFIGURACAO DO AMBIENTE DE EDICAO
" *993      -  FUNCOES E MAPEAMENTOS PADROES
" *1067     -  ARQUIVOS  CARREGADOS
" *1297     -  DEBUG E ALTERACOES DO DOCUMENTO
" *1321     -  NOTAS POR VERSAO
" *1327     -  AJUDA
" *1344     -  BIBLIOGRAFIA
" *1404     -  CREDITOS
" *1441     -  DICAS
"
"---------------------------------------------------------------
"
"
"=============================================================================
"I N T R O D U C A O                                             (VI-IMproved)
"=============================================================================
" VI é um  Editor Visual (do inglês Visual Interface). Em um editor visual
" podemos ver as linhas que estão sendo editadas, ao contrário do sed por
" exemplo que é um editor não visual.
"
"(1) VI - Visual Interface
"
"  VI foi programado por William Joy na Universidade da Califórnia como parte
"  da distribuição BSD. Posteriormente usado pela AT&T, e foi inserido desde
"  então na base do Unix.
"
"(2) VIM - VI-IMproved
"
"  Vim (VI iMproved) é um editor de texto altamente configurável projetado de
"  forma a permitir a edição rápida e eficiente de texto. É uma versão
"  melhorada do editor vi que é distribuído com a maioria dos sistemas UNIX.
"
"  O autor principal e mantenedor, Bram Moolenaar <bram@vim.org>.
"  HomePage do vim na WWW:
"  http://www.vim.org/
"
"(3) GVIM - Graphic-VI-IMproved
"
"  O vim no modo gráfico e com suporte a mouse. A grande vantagem dessa versão
"  é a possibilidade de configurar o editor como uma ide de programação onde
"  onde pode-se criar botões e janelas.
"
"
"
" Arquivo[e ou]tipo                    Definição
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"
" Dotfiles           Arquivos conhecidos como dotfile ou Prototype Dotfiles
"                    contém as configurações iniciais de um programa.
"
" vimrc              Arquivo do tipo dotfile que contém as configurações do
"                    ambiente de edição do editor visual Vim.
"
" nomeArquivo.vim    Arquivo do tipo vim que contém scripts vim. Scripts-vim
"                    são usados para configurar cores e ou automatizar
"                    editoração.
"
"
"
"=============================================================================
"I N S T A L A C A O                                             (VI-IMproved)
"=============================================================================
"
" O arquivo .vimrc pode ser instalado de duas formas distintas, sendo elas
" colocando o arquivo em questão em seu diretório de trabalho, ou invocando o
" mesmo usando o comando  vi[m] -U .vimrc  arquivo_a_ser_editado no prompt do
" shell.
"
"
"
" Configuração de variáveis de ambiente
" -------------------------------------
"
"  Algumas variáveis de ambiente podem ser usadas para alterar o
"  comportamento padrão das funções. Basta defini-las em seu .vimrc ou na
"  própria linha de comando antes de chamar as funções. São elas:
"
"    $ICMAIL[0X]   - Endereço de Mail do usuário
"    $ICURL[0X]    - Pagina de internet do Usuário
"    $ICPATHCONF   - Caminho completo para o diretório com as configurações
"    $ICPATHBACKUP - Caminho completo para o diretório de armqzenamento
"                    de Backup
"
"   Uma forma prática de se trabalhar com variáveis de ambiente é definilas em
"   algum arquivo shell de configuração, por exemplo, dentro do arquivo
"   .bashrc adicione as seguintes linhas:
"
"     export MAIL01="ivanczar78@yahoo.com.br"
"     export MAIL02="ivan.carlos78@gmail.com"
"     export URL01="http://www.del.ufrj/~ivanczar/"
"     export PATHBACKUP="/cygdrive/G/principal/work/bkup"
"     export PATHCONF="~/data"
"
"   Feito isso, basta usar variáveis-vim de ambiente no formato let $name-Var
"   para que qualqueir funcao ou chamada vim possa utilizar estas variáveis.
"
let         $ICAUTOR=expand($AUTOR)
let  $ICUNIVERSIDADE=expand($UNIVERSIDADE)
let  $ICDEPARTAMENTO=expand($DEPARTAMENTO)
let        $ICMAIL01=expand($MAIL01)
let        $ICMAIL02=expand($MAIL02)
let         $ICURL01=expand($URL01)
let      $ICPATHCONF=expand($PATHCONF)
let    $ICPATHBACKUP=expand($PATHBACKUP)

"
" É importante ressaltar que o formato acima pode ser substituído por
" variáveis globais caso queira definir no próprio arquivo .vimrc, evitando
" a definição em arquivos shell de configuração.
"
"     let  g:MAIL01     = 'ivanczar78@yahoo.com.br'
"     let  g:MAIL02     = 'ivan.carlos78@gmail.com'
"     let  g:URL01      = 'http://www.del.ufrj/~ivanczar/'
"     let  g:PATHBACKUP = '/cygdrive/G/principal/work/bkup/'
"     let  g:PATHCONF   = '~/data'
"

if !has("win32") " cygwin ou linux -------------------------------------------
" Modo Cygwin prompt-texto
	"echo "CYGWIN"
" Opcoes linux entrariam aqui ....

else " tem windows -----------------------------------------------------------	

	" -----------------------------cywin-Win32-Gvim----------------------------
	if has("gui_running") && exists("$ICPATHCONF")
"		echo "CYGWIN-Gvim"
		let $ICPATHCONF  =matchstr(system('cygpath -m '.$PATHCONF),  "^.*\\ze\n")
		let $ICPATHBACKUP=matchstr(system('cygpath -m '.$PATHBACKUP),"^.*\\ze\n")
	else  " sem cygwin --------------------------------------------------------
		if $OS=~"Windows_NT"
"			echo "Gvim-Win32"
			let         $ICAUTOR="Ivan Carlos Da Silva Lopes"
			let  $ICUNIVERSIDADE="Universidade Federal Do Rio de Janeiro"
			let  $ICDEPARTAMENTO="Departamento De Eletrônica e Computação Del - UFRJ"
			let        $ICMAIL01='ivanczar78@yahoo.com.br'
			let        $ICMAIL02='ivan.carlos78@gmail.com'
			let         $ICURL01='http://www.del.ufrj/~ivanczar/'
			let     $ICPATHCONF ="E:/cygWin/cygwin-root/cygwin/home/ivanczar/data"
			let    $ICPATHBACKUP="D:/principal/work/bkup"

			map <F5> :%s/http/\r&/g<cr>
					  \:%s/htm[l]\=/&\r/g<cr>
					  \:%v/^http/ d<cr>
			    	  \:%v/htm[l]\=/ d<cr>
			map <F6> :yank *<cr>
		endif
	endif
"-----------------------------------------------------------------------------
endif 
"
"
"windous
"+--------------------------------+
"|                                |      
"|                                |
"|                                |              Linux 
"|   Cygwin          +--------------------------------+
"|  +------------+   |            |                   |
"|  | gvim       |   | gvim       |                   |
"|  |            |   |            |                   |
"|  | vim-prompt |   | vim-prompt |                   |
"|  +------------+   |            |                   |
"|                   |  <.vimrc>  |                   |
"+-------------------|------------+                   |
"                    |                                |
"                    +--------------------------------+
"
"
" Configurando compiladores ativos para serem utilizados por scripts
" ------------------------------------------------------------------
"
" O sistema operacional possui compiladores, para tanto devemos informar ao
" vom qual destes encontra-se ativo, ou seja, se os mesmos foram instalados
"
"
" VAMOS UTILIZAR VARIÁVEIS GLOBAIS PARA QUE AS MESMAS SEJAM LIDAS
" DENTRO DOS ESCOPOS DAS FUNÇÕES.
"
"let     g:CansiGNUColectionCompiler=1       " C-ansi     GCC
"let g:CplusplusGNUColectionCompiler=1       " Cplusplus  GCC
"let      g:JAVAGNUColectionCompiler=1       " Java       GCC
"let       g:PASCALColectionCompiler=1       " Pascal     GCC
"let   g:FORTRANGNUColectionCompiler=0       " Fortran    GCC
"let       g:ADAGNUColectionCompiler=0       " Ada        GCC
"let g:ObjetiveCGNUColectionCompiler=0       " Objetive-c GCC
"let               g:JavaSunCompiler=1       " Java       sun
"let             g:LCC_WIN32Compiler=1       " C-ansi     LCC
"let                    g:CLCompiler=1       " CPP        MS
"
"
"
"
"
"=============================================================================
"CONFIGURACAO DO AMBIENTE DE EDICAO                              (VI-IMproved)
"=============================================================================
"
" Aqui vamos tornar o nosso editor mais amigável, para tanto, adicionaremos
" configurações de cores, mapeamento de funções, ativação de modos e
" configuração de variáveis de ambiente para serem usadas pelos futuros
" scripts.
"
" Para tanto devemos utilizar as configurações precedidas pelo comando
" set[local].
"
  " **************************************************************************
  " *                                                                        *
  " * use VIM padrão é muito melhor                                          *
  " *                                                                        *
  " **************************************************************************
setlocal nocompatible

  " **************************************************************************
  " *                                                                        *
  " *(compatible) Torna o comportamento do VIM o mais próximo possível do VI.*
  " *                                                                        *
  " **************************************************************************
"setlocal cp

  " **************************************************************************
  " *                                                                        *
  " *   Numerando as linhas do arquivo, isto é, qualquer arquivo carregado é *
  " *   editado com a numeração de linhas ligada                             *
  " *                                                                        *
  " **************************************************************************
setlocal number

  " **************************************************************************
  " *                                                                        *
  " * Exibe o modo atual de operações do VI (Inserção ou comandos)           *
  " * Mostra o modo que você esta.                                           *
  " *                                                                        *
  " **************************************************************************
setlocal showmode

  " **************************************************************************
  " *                                                                        *
  " * (beautfy)- Usando essa opção, todos os caracteres de controle (a não   *
  " *  ser "tab", "linefeed" e "formfeed") serão descartados do texto ao ser *
  " *  carregados.                                                           *
  " *                                                                        *
  " **************************************************************************
"setlocal bf

  " **************************************************************************
  " *                                                                        *
  " *       Recua cada linha para o mesmo nível da linha superior            *
  " *                                                                        *
  " **************************************************************************
setlocal autoindent

  " **************************************************************************
  " *                                                                        *
  " *   Utilizando abreviações em linha de comando                           *
  " *   Para tanto vamos utilizar o comando Cab                              *
  " *                                                                        *
  " **************************************************************************
cab W  w
cab Wq wq
cab wQ wq
cab WQ wq
cab Q  q

  " **************************************************************************
  " *                                                                        *
  " * Os comandos de abreviação podem também ficar em uma única linha        *
  " * cab W w | cab Q q | cab Wq wq | cab wQ wq | cab WQ wq                  *
  " *                                                                        *
  " **************************************************************************


  " **************************************************************************
  " *                                                                        *
  " * ShiftWidth: número de colunas deslocadas pelo comando > ou <           *
  " *                                                                        *
  " **************************************************************************
setlocal sw=3

  " **************************************************************************
  " *                                                                        *
  " * régua: mostra a posição do cursor                                      *
  " *                                                                        *
  " **************************************************************************
setlocal ruler

  " **************************************************************************
  " *                                                                        *
  " * SHortMessages: encurta as mensagem da régua                            *
  " *                                                                        *
  " **************************************************************************
setlocal shm=filmnrwxt

  " **************************************************************************
  " *                                                                        *
  " * ShowMatch: Toda vez que você fecha um parêntese, colchete              *
  " * ou chave, o Vi mostra onde este foi aberto. Caso  não haja             *
  " * nenhum aberto para este, deixa em vermelho parênteses ou               *
  " * chaves que não têm um par.                                             *
  " *                                                                        *
  " **************************************************************************
setlocal sm

  " **************************************************************************
  " *                                                                        *
  " * tab com complemento de palavras automático                             *
  " *                                                                        *
  " **************************************************************************
setlocal wildmode=list:longest,full

  " **************************************************************************
  " *                                                                        *
  " * mostra os comandos sendo executados                                    *
  " *                                                                        *
  " **************************************************************************
setlocal showcmd

  " **************************************************************************
  " *                                                                        *
  " * reporta ações com linhas no rodapé                                     *
  " *                                                                        *
  " **************************************************************************
setlocal report=0

  " **************************************************************************
  " *                                                                        *
  " * tabstop: número de colunas para o comando <tab>                        *
  " *                                                                        *
  " **************************************************************************
setlocal ts=3

" A tecla TAB no vim vem padronizada com 8 espaços, sendo assim, quando
" editar um código em c, c++, pascal ou outra linguagem qualquer o texto
" do código torna-se algo meio confuso, principalmente quando o código é
" longo e possui inúmeros escopos. Para tanto, podemos mudar o tamanho do
" TAB, isto é do número de espaços gerados pelo mesmo, utilizando o comando
" 'setlocal tabstop=3' que transforma o tamanho do TAB de 8 para 3.

  " **************************************************************************
  " *                                                                        *
  " * coloca 2 espaços após o . quando usando o gq                           *
  " *                                                                        *
  " **************************************************************************
"set nojoinspaces

  " **************************************************************************
  " *                                                                        *
  " * Usando <BkSpc> para deletar linha                                      *
  " *                                                                        *
  " **************************************************************************
setlocal backspace=eol,start,indent

  " **************************************************************************
  " *                                                                        *
  " * (window)Define o número de linhas deslocadas com os comandos           *
  " * ^B (Ctrl+B) e ^F (Ctrl+F)                                              *
  " *                                                                        *
  " **************************************************************************
setlocal window=10

  " **************************************************************************
  " *                                                                        *
  " * Define o número de linhas deslocadas com os comandos                   *
  " * ^U (Ctrl+U) e ^D (Ctrl+D)                                              *
  " *                                                                        *
  " **************************************************************************
setlocal scroll=5

  " **************************************************************************
  " *                                                                        *
  " * Em caso de se cometer um comando inválido aciona-se um alarme visual   *
  " * visual-bells                                                           *
  " *                                                                        *
  " **************************************************************************
set visualbell

  " **************************************************************************
  " *                                                                        *
  " * Aqui definimos para vim onde encontrar o arquivo com as cores do fvwm  *
  " * É importante ressaltar que essa opção está configurada para CygWin     *
  " *                                                                        *
  " **************************************************************************

"cab RGB  exec "e ". expand(g:rgb_file)
"let g:rgb_file="/usr/X11R6/lib/X11/rgb.txt"    "Cygwin
"let rgb_file="/usr/X11R6/lib/X11/rgb.txt"    Linux-Conectiva-8

  " **************************************************************************
  " *                                                                        *
  " * Aqui definimos uma chave para a alternância entre os modos:            *
  " *                                                                        *
  " * -- INSERT (paste) --          e             -- INSERT --               *
  " *                                                                        *
  " *  O primeiro não segue o padrão de linha Identada  enquanto o segundo   *
  " *  é o modo normal de trabalho.                                          *
  " *                                                                        *
  " **************************************************************************
set pastetoggle=<F2>

  " **************************************************************************
  " *                                                                        *
  " *  <F12>   Esconde comentário    liga ou desliga comentário              *
  " *  <F11>   numeração lateral     liga ou desliga numeração               *
  " *  <F10>   tabulação             liga ou desliga tabulação               *
  " *  <F9>    backup                                                        *
  " *                                                                        *
  " *                                                                        *
  " *  <F3>    meu help                                                      *
  " *  <F2>    insert (paste)                                                *
  " *                                                                        *
  " *                                                                        *
  " *  ;l      limpa                 retira espaços em branco de final       *
  " *                                de arquivo.                             *
  " *                                                                        *
  " *                                                                        *
  " *  ,bi    Edição binária        liga ou desliga edição binária           *
  " *                                                                        *
  " *                                                                        *
  " *                                                                        *
  " **************************************************************************
map <F12> :call HideShowComment()<cr>
map <F11> :call TurnOnOffNumber()<cr>
map <F10> :call TurnOnOff_TAB_EOF()<cr>
map <F9>  :call BackupNomeData()<cr>
map <F3>  :call AjudaUsuario()<cr>

" utilizando o dicionário aspell
map \BR :w!<CR>:!aspell check %<CR>:e! %<CR>
map \EN :w!<CR>:!aspell --lang=en check %<CR>:e! %<CR>

map ,bi  :call TurnOnOff_EDITOR_BINARIO()<cr>
map ;l   :%s/\s*$//g<cr>

  " **************************************************************************
  " *                                                                        *
  " * Esse mapeamento gera uma cruz colorida (*selecionar linha do cursor    *
  " * e selecionar colina do cursor *)                                       *
  " *                                                                        *
  " **************************************************************************
"highlight CRUZ ctermbg=blue ctermfg=black
"map ;cz  :exe 'match CRUZ /\%' . line(".") . 'l\\|\%' . col(".") . 'c'<cr>

  " **************************************************************************
  " *                                                                        *
  " *   geralmente usamos ^I para representar uma tabulação                  *
  " *   <Tab>, e $ para indicar o fim de linha. Mas é possível               *
  " *   customizar essas opções. sintaxe:                                    *
  " *                                                                        *
  " *   set listchars=key:string,key:string                                  *
  " *                                                                        *
  " *                                                                        *
  " * - eol:{char}                                                           *
  " *                                                                        *
  " *     Define o caracter a ser posto depois do fim da linha               *
  " *                                                                        *
  " * - tab:{char1}{char2}                                                   *
  " *                                                                        *
  " *     O tab é mostrado pelo primeiro caracter {char1} e                  *
  " *     seguido por {char2}                                                *
  " *                                                                        *
  " * - trail:{char}                                                         *
  " *                                                                        *
  " *     Esse caracter representa os espaços em branco.                     *
  " *                                                                        *
  " * - extends:{char}                                                       *
  " *                                                                        *
  " *    Esse caracter representa o início do fim da linha  sem quebra-la    *
  " *    Está opção funciona com a opção nowrap abilitada                    *
  " *                                                                        *
  " **************************************************************************
  "exemplo 1:
"set listchars=tab:>-,trail:.,eol:#,extends:@

  "exemplo 2:
"set listchars=tab:>-


  "exemplo 3:
"set listchars=tab:>-

  "exemplo 4:
set nowrap    "Essa opção desabilita a quebra de linha
"set listchars=extends:+


  " **************************************************************************
  " *                                                                        *
  " * Em caso de se cometer um comando inválido aciona-se um alarme sonoro   *
  " * error-bells                                                            *
  " *                                                                        *
  " **************************************************************************
"set eb

  " **************************************************************************
  " *                                                                        *
  " * Antes de sobrescrever um arquivo mantém um backup do mesmo             *
  " *                                                                        *
  " * por exemplo, após salvar um arquivo de nome Alfa.txt, o vim cria uo    *
  " * outro arquivo chamado Alfa.txt~ com a configuração anterior do arquivo *
  " * antes do  mesmo ser alterado                                           *
  " *                                                                        *
  " **************************************************************************
"set bk

  " **************************************************************************
  " *                                                                        *
  " * usar a pasta pessoal de backup                                         *
  " *                                                                        *
  " **************************************************************************
"set backupdir=$ICPATHBACKUP

  " **************************************************************************
  " *                                                                        *
  " * Habilita a mudança de coluna quando movimenta-se através das linhas    *
  " *                                                                        *
  " **************************************************************************
"set startofline

  " **************************************************************************
  " *                                                                        *
  " * Eu gosto mas do formato UNIX                                           *
  " *                                                                        *
  " **************************************************************************

" evento: lendo arquivo (*O ARQUIVO EXISTE EM DISCO*)
" converte para o formato unix todo arquivo trabalhado
" a conversão em múltiplos arquivos ocorre  quando o buffer referente ao
" arquivo é criado.
autocmd! BufReadPost * call Dos2UNIX()

  " **************************************************************************
  " *                                                                        *
  " *             Fechamento automático para parênteses                      *
  " *                                                                        *
  " **************************************************************************

"imap ( ()<esc>i
"inoremap ( ()<esc>i
"inoremap { {<Char-13>}<esc>i
"inoremap [ []<esc>i

  " **************************************************************************
  " *                                                                        *
  " * Diretórios onde o VIM busca por arquivos                               *
  " *                                                                        *
  " **************************************************************************
set path=.,/usr/include/,/usr/local/bin/

  " **************************************************************************
  " *                                                                        *
  " *exemplo de como usar o dicionário com mapeamento:                       *
  " * (1)  dentro do modo de inserção       -- INSERT --                     *
  " * (2)  posicione o cursor sob a palavra a ser completada                 *
  " * (3)  ligar dicionário  ao pressionar a seqüencia  "CTRL+d"             *
"imap <c-d> <c-x><c-k>
  " * (4)  Completa uma palavra de forma ascendente     "<F7>"               *
"imap <F7> <c-n>
  " * (5)  Busca palavra no arquivo corrente            "<F8>"               *
"imap <F8> <c-x><c-n>
  " *                                                                        *
  " **************************************************************************

  " **************************************************************************
  " *                                                                        *
  " *  Quando completar uma palavra seguir a seguinte seqüencia de           *
  " *  busca, sendo primeiro em 1, segundo em 2, ...                         *
  " *                                                                        *
  " * 1 - no buffer atual                  (.)                               *
  " * 2 - buffer de outra janela           (w)                               *
  " * 3 - outros buffers carregados        (b)                               *
  " * 4 - buffers não carregados           (u)                               *
  " * 5 - arquivo de tags                  (t)                               *
  " * 6 - arquivo de include               (i)                               *
  " * 7 - dicionário                       (K)                               *
  " *                                                                        *
  " *                                                                        *
  " complete=.,w,b,u,t,i,k     (*default*)                                   *
  " *                                                                        *
  " *                                                                        *
  " **************************************************************************
"setlocal complete=.,w,k,t,i
set complete-=k complete+=k
"o comando acima ativa o formato i_Ctrl_n_Ctrl_n para ativar o dicionário

  " **************************************************************************
  " *                                                                        *
  " * Completa a palavra ignorando se é maiúscula ou minúscula               *
  " *                                                                        *
  " **************************************************************************
setlocal infercase

  " **************************************************************************
  " *                                                                        *
  " * se uma linha ultrapassar o valor estipulado em textwidth ela será      *
  " * mostrada em destaque colocá-la em uma função de liga desliga junto     *
  " * com uma que mostre as linhas e colunas de um arquivo em destaque       *
  " *                                                                        *
  " **************************************************************************
"au BufNewFile,BufRead  *  exec 'match Error /\%>' .  &textwidth . 'v.\+/'

" ****************************************************************************
" *                                                                          *
" *          Proteção De Arquivos                                            *
" *                                                                          *
" ****************************************************************************

  " **************************************************************************
  " * Arquivos somente de leitura, não é permitido alterá-los                *
  " * dotfile                                                                *
  " *                                                                        *
  " **************************************************************************
"augroup dotfile
"  au!
"  au BufRead  .*  set readonly
"augroup END

  " **************************************************************************
  " *                                                                        *
  " *  Alguns tipos de arquivos devem ser ignorados pelo editor              *
  " *                                                                        *
  " **************************************************************************
set wildignore=*.o,*.obj,*.bak,*.exe

" ****************************************************************************
" *                                                                          *
" *          Configuração da barra de status                                 *
" *                                                                          *
" ****************************************************************************

  " **************************************************************************
  " *  Uma configuração interessante é defini-la com tamanho de duas linhas e*
  " *  fundo com cor azul e fonte branca.                                    *
  " *                                                                        *
  " **************************************************************************
setlocal laststatus=2                                    "Mostrar duas linhas.
highlight StatusLine ctermfg=blue   ctermbg=white  "Fundo azul e fonte branca.

  " **************************************************************************
  " *                                                                        *
  " *          configurando o formato da régua                               *
  " *                                                                        *
  " **************************************************************************
set statusline=%t%m%r%h%w
	\%=[FORMATO=%{&ff}]
	\[TIPO=%Y]
	\[CHAR=%3{GetCharCursor()}]
	\[ASCII=%03b]
	\[HEX=%02B]
	\[\ XY=%04v,%04l]
	\[%03P]

" ****************************************************************************
" *                                                                          *
" *          Configuração do Título                                          *
" *                                                                          *
" ****************************************************************************

  " **************************************************************************
  " *                                                                        *
  " *      Mostra o nome do arquivo na parte superior do prompt              *
  " *                                                                        *
  " **************************************************************************
set title

  " **************************************************************************
  " *                                                                        *
  " *     Mostra a mensagem selecionada quando sair do VIM                   *
  " *                                                                        *
  " **************************************************************************
"set titleold=Ivan\ Carlos\ Da\ Silva\ Lopes

  " **************************************************************************
  " *                                                                        *
  " *            Tamanho da barra de título                                  *
  " *                                                                        *
  " **************************************************************************
"set titlelen=78

  " **************************************************************************
  " *                                                                        *
  " *         Exibe a barra de título no formato configurado                 *
  " *                                                                        *
  " **************************************************************************

  " **************************************************************************
  " * exemplo1:                                                              *
  " * ---------                                                              *
  " *                                                                        *
  " * formato:"nome="NomeArq.EXT [se alterado mostrar +]                     *
  " * set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)       *
  " *                                                                        *
  " *                                                                        *
  " * exemplos2:                                                             *
  " * ----------                                                             *
  " *                                                                        *
  " * set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:p\")})%)%(\ %a%)           *
  " *                                                                        *
  " **************************************************************************
set titlestring=%<Nome=%t%m%r%h%w
\%=
\BUFFER=%n
\%(\ %a%)
\%28([TOTAL\ DE\ LINHAS=%L]%)


" -------------------------- [Formato] ---------------------------------------
" [Nome=nome]       buffer={current}   [Total de linhas=999]                 '
" ----------------------------------------------------------------------------

" Se editar múltiplos arquivos
" ----------------------------------------------------------------------------
" [Nome=nome]  buffer={current} [{current} of {max})]  [Total de linhas=999] '
" ----------------------------------------------------------------------------


" ****************************************************************************
" *                                                                          *
" *          Definindo o formato de edição dos textos                        *
" *                                                                          *
" ****************************************************************************

  " **************************************************************************
  " *                                                                        *
  " * Define qual é o tamanho da margem direita para a quebra de linhas      *
  " * automáticas                                                            *
  " * wrapmargin                                                             *
  " *                                                                        *
  " **************************************************************************
"setlocal wm=10

  " **************************************************************************
  " *                                                                        *
  " *  Quando esta opção encontra-se ativa o VIM lê o arquivo, e qualquer    *
  " *  comando de configuração que estiver nas cinco primeiras linhas e cinco*
  " *  ultimas do arquivo, serão executados. Um exemplo disso são os arquivos*
  " *  do help, onde as últimas linhas a apresentam a seguinte sintaxe:      *
  " *  'vim:tw=78:ts=8:ft=help:norl:'                                        *
  " *                                                                        *
  " **************************************************************************
setlocal modeline

  " **************************************************************************
  " *                                                                        *
  " *  Definindo tamanho da linha, isto é, coluna onde a linha deve ser      *
  " *  quebrada" com a inserção de fim de linha (<EOL>, abreviação de        *
  " *  end-of-line).                                                         *
  " *                                                                        *
  " **************************************************************************
setlocal textwidth=78

  " **************************************************************************
  " * acentuação                                                             *
  " * ----------                                                             *
  " *                                                                        *
  " *  SE não tiver suporte para acentuação                                  *
  " *  retire as aspas das linhas mapeadas abaixo                            *
  " *                                                                        *
  " **************************************************************************
"map! 'a á
"map! 'A Á
"map! 'e é
"map! 'E É
"map! 'i í
"map! 'I Í
"map! 'o ó
"map! 'O Ó
"map! ~a ã
"map! ~A Ã
"map! ^a â
"map! ^A Â
"map! `a à
"map! `A À
"map! ,c ç
"map! ,C Ç
"map! ^e ê
"map! ^E Ê
"map! ^o ô
"map! ^O Ô
"map! ~o õ
"map! ~O Õ
"map! 'u ú
"map! 'U Ú


" ****************************************************************************
" *                                                                          *
" *          Definindo e trabalhando com histórico da linha de comando       *
" *                                                                          *
" ****************************************************************************

  " **************************************************************************
  " *                                                                        *
  " * histórico da linha de comando                                          *
  " *                                                                        *
  " **************************************************************************
setlocal cedit=<Esc>

  " **************************************************************************
  " *                                                                        *
  " * (^[ é o caracter ESC)                                                  *
  " * Habilitando a apresentação do histórico da linha de comando com o      *
  " * comando esc. Por exemplo, escrevendo ':' e depois pressionando-se      *
  " * ESC, abre-se uma janela com a lista dos comandos anteriores. A relação *
  " * pode ser modificada  como se fosse um arquivo. Quando se pressiona     *
  " * Enter sobre uma linha o  comando correspondente é executado.           *
  " *                                                                        *
  " **************************************************************************

  " **************************************************************************
  " *                                                                        *
  " * (history) Define o tamanho do arquivo de histórico, onde <valor> é o   *
  " * número de linhas de comandos a serem armazenados                       *
  " * setlocal hi=<valor>                                                    *
  " *                                                                        *
  " **************************************************************************
setlocal hi=5000

  " **************************************************************************
  " *                                                                        *
  " * Guarda posição do cursor e histórico da linha de comando :             *
  " *                                                                        *
  " **************************************************************************
setlocal viminfo='100,\"1000,:40,%,n~/.viminfo

"au BufReadPost * if line("'\"")|execute("normal `\"")|endif

autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

" ****************************************************************************
" *                                                                          *
" *          Cores do sistema e formato de busca                             *
" *                                                                          *
" ****************************************************************************

  " **************************************************************************
  " *                                                                        *
  " *   Adicionando fundo escuro.                                            *
  " *                                                                        *
  " **************************************************************************
setlocal background=dark

  " **************************************************************************
  " *                                                                        *
  " * Ligando configurações de cor, isto é, faz com que o vim busque no      *
  " * diretório /usr/share/vim/vim62/syntax os arquivos de configuração de   *
  " * cores de acordo com o tipo de arquivo que é aberto                     *
  " *                                                                        *
  " **************************************************************************
syntax on

  " **************************************************************************
  " *                                                                        *
  " * Ativa o recurso de colorir, dando realce a pesquisa de palavra(s)      *
  " * que estiver em andamento.                                              *
  " *                                                                        *
  " **************************************************************************
setlocal hlsearch                                 " ativa o contraste de cores
                                               "hlsearch possui abreviação hls
  " **************************************************************************
  " *                                                                        *
  " * O método de busca pode ser incrementado com a adição do comando        *
  " * incsearch". A pesquisa torna-se diferenciada e dinâmica em tempo de    *
  " * pesquisa, isto é, antes do usuário entrar com o comando <enter> a fim  *
  " * de buscar os resultados, os mesmos já aparecerão em sua tela.          *
  " *                                                                        *
  " **************************************************************************
setlocal incsearch

  " **************************************************************************
  " *                                                                        *
  " * Que tal trocar a cor do texto ?                                        *
  " * daquela seleção que aparece quando você procura algo com o comando     *
  " * / ? é fácil, basta definir a cor do componente da sintaxe. ah sim, a   *
  " * opção  hls (veja abaixo) deve estar ativa.                             *
  " * você pode colocar as cores que quiser, em inglês. note que é           *
  " * ctermBG e FG, de  background e foreground  (fundo e letra). e veja     *
  " * também que o IncSearch (busca enquanto você digita) é invertido!       *
  " *                                                                        *
  " **************************************************************************
hi    Search ctermbg=yellow ctermfg=red
hi IncSearch ctermbg=green  ctermfg=cyan

  " **************************************************************************
  " *                                                                        *
  " * no vim temos diversas opções para  modificar seu comportamento         *
  " * através do comando set. para ver  todas as opções  disponíveis, faça   *
  " * :setlocal all. diversas  opções já vêem  ligadas por  padrão, então    *
  " * vamos mais opções de busca                                             *
  " * IncrementedSearch, HighLightedSearch, IgnoreCase e SmartCaSe           *
  " *                                                                        *
  " **************************************************************************
setlocal ic scs                   "  opções espertas de busca

  " **************************************************************************
  " *                                                                        *
  " *               Cor da numeração lateral                                 *
  " *                                                                        *
  " **************************************************************************
"hi LineNr     guifg=pink     ctermfg=lightMagenta
"hi LineNr     guifg=green    ctermfg=lightGreen

" ****************************************************************************
" *                                                                          *
" *          configurações especiais                                         *
" *                                                                          *
" ****************************************************************************

"cores

"t_Co número de cores
"t_Sb tipo de cor do plano de fundo
"t_Sf tipo de cor da fonte

if &term =~ "xterm" || &term =~ "linux"
  set background=dark
  set t_Co=8
  set t_Sf=[3%dm
  set t_Sb=[4%dm
endif

" Delete key
if &term =~ "xterm"
  set t_kD=[3~
endif

if argc() > 8
   nmap > :bn<CR>
   nmap < :bp<CR>
endif

  " **************************************************************************
  " * Faz o shift-insert comportar-se semelhante ao Xterm                    *
  " * Sendo assim você seleciona um bloco de texto com o mouse               *
  " * e cola com o botão do meio do mouse                                    *
  " **************************************************************************
map  <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

  " **************************************************************************
  " *                                                                        *
  " * Utilizando a barra de espaço para mover  uma página                    *
  " *                                                                        *
  " **************************************************************************
"noremap <Space> <PageDown>

  " **************************************************************************
  " *                                                                        *
  " * O dicionário  de português   está associado ao comando dictionary      *
  " *                                                                        *
  " * Dicionário para procurar o auto-complemento de palavras                *
  " *                                                                        *
  " *                                                                        *
  " **************************************************************************
set dictionary=$ICPATHCONF/dict/portugues/portugues.api


"=============================================================================
"FUNCOES E MAPEAMENTOS PADROES                                   (VI-IMproved)
"=============================================================================
"
"             -- Funções básicas usadas pelo editor vim --
so $ICPATHCONF/func/funcBasicas.vim
so $ICPATHCONF/func/increment.vim
so $ICPATHCONF/func/blocos.vim
"so $ICPATHCONF/func/completingEqualShell.vim
"
"             -- Mapeamento das funções e teclas --
so $ICPATHCONF/mapa/mapa.vim
so $ICPATHCONF/mapa/mapafuncBasicas.vim
"
"
"
"             -- Abreviações de palavras --
source $ICPATHCONF/abbreviation/acento.vim
"
"             -- Lendo Manpage no editor
runtime ftplugin/man.vim"
"
"
"             -- Exportando o arquivo --
"
" Exporta o arquivo no formato html.
cab buffer2html
    \  :source $ICPATHCONF/syntax/2html.vim<cr>
    \  :%s/<pre>/<pre>\r<font size=+2>/g<cr>
    \  :%s/<\/pre>/<\/font>\r<\/pre>/g<cr>
    \  :wq<cr>
    \  :echo "O buffer " . expand("%p:r") . " foi impresso no formato HTML"

"             -- C O R E S --
" Mapeamento para configurar as cores do prompt de comando
cmap cor Cor
com -nargs=1 Cor call ColoreTerminal(<arg>)
com -nargs=0 Testacor :let i=0
	 \|	 while i<=ArraySize(g:ArrayOfcolors,'')
    \|		 call ColoreTerminal(i)
    \|		 let i=i+1
	 \|		 sleep
	 \|		 redraw
	 \|		 if exists('g:colors_name')
	 \|			call Message('info',g:colors_name.' - '.i)
	 \|		 else 
    \|			call Message('Erro',"variável g:colors_name[".i."] não definida")
	 \|		 endif
	 \|	 endwhile
 
"  Carrega arquivo corrente.
cab carrega so %<cr>:call Message('info',"arquivo carregado")<cr>

"             -- M  O V I M E N T A C A O --
"
" Movimentando grupo de texto.
"
"             -- Linhas --
nnoremap <C-j> :call LinhaDesce()<cr>
nnoremap <C-k> :call LinhaSobe()<cr>
"
"             -- Colunas --
" Movimentando-se para o lado direito
nnoremap <C-l> :call ColunaDEstra()<cr>
" Movimentando-se para o lado esquerdo
nnoremap <C-h> :call ColunaSInistra()<cr>

" Converte formato de janelas
com  Hz :windo wincmd K
			\|call Message('info','-- Horizontal --')<cr>
com  Vt :windo wincmd H
			\|call Message('info','-- Vertical --')<cr>
cmap hz Hz
cmap vt Vt
"=============================================================================
"A R Q U I V O S  C A R R E G A D O S                            (VI-IMproved)
"=============================================================================
" Nessa parte do código vamos utilizar um mapeamento do tipo grupo, ou seja,
" de acordo com o tipo de arquivo vamos carregar determinadas propriedades do
" mesmo e eliminar propriedades carregadas não válidas patra os mesmos.
" Aliviando portanto a área de memória utilizada pelo editor e customizando a
" velocidade de processamento.
"
" Os grupos estão divididos em 7, sendo os mesmos:
"   + grupo pascal
"   + grupo vim
"   + grupo algoritmo
"   + grupo java
"   + grupo cansi_cpp
"   + grupo txt
"   + grupo markuplanguage


" evento: se o arquivo não existe em disco
" Carrega um cabecalho dinâmico referente as configurações do tipo de arquivo
" editado.
autocmd BufNewFile  *  so $ICPATHCONF/func/cabecalho.vim | call GetHeader()

augroup pascal
   au!
" Os arquivos pascal podem ter o seguinte formato
" <: (*.pas, *.PAS, *.PP, *.pp, inc, etc.) :>
"confguração: {{{
"
" evento: se o arquivo não existe em disco
" Carrega configurações pessoais do arquivo, como cores, mapeamento de
" teclado, tipo de comentário e configuração de IDE para o Gvim.
   au BufNewFile,BufReadPre *.\(pas\|pp\|inc\)
    		  	\ source $ICPATHCONF/autocom/pascal.autocom.vim
"
" evento: lendo arquivo (*O ARQUIVO EXISTE EM DISCO*)
" posiciona o cursor na primeira ocorrência da palavra 'início'
   au BufRead     *.\(pas\|pp\)   1;/begin
"
" evento: Entrando e saindo do arquivo  (*O ARQUIVO PODE OU NÃO EXISTIR*)
" ao entrar acrescenta dicionário novo, e retira dicionário de palavras
" ao sair.
   au BufEnter *.\(pas\|pp\|inc\) call Dicionario()
   au BufEnter *.\(pas\|pp\|inc\) call Dicionario('Liga')
   au BufLeave *.\(pas\|pp\|inc\) call Dicionario('Desliga')
   au BufLeave *.\(pas\|pp\|inc\) call Dicionario("portugues")
"}}}
augroup END

augroup VIM
au!
" Definindo a configuração de arquivos VIM
"confguração: {{{
"
" evento: se o arquivo não existe em disco
" Carrega configurações pessoais do arquivo, como cores, mapeamento de
" teclado, tipo de comentário e configuração de IDE para o Gvim.
   autocmd BufNewFile,BufReadPre *.vim so $ICPATHCONF/autocom/vim.autocom.vim
"
" evento: lendo arquivo (*O ARQUIVO EXISTE EM DISCO*)
" Marca os cabecalhos das funcoes vim
   autocmd BufRead *.vim
	\ exe "map ,, :g/^func\\(tion\\)\\=!\\=\\s\\+\\(:[sS]\\)\\=[A-Z].*/ p <cr>"
"}}}
augroup END

augroup SH
   au!
" Definindo a configuração de arquivos sh
"confguração: {{{
"
" evento: se o arquivo não existe em disco
" Carrega configurações pessoais do arquivo, como cores, mapeamento de
" teclado, tipo de comentário e configuração de IDE para o Gsh.
	autocmd BufNewFile,BufReadPre   *.sh
   			\ so $ICPATHCONF/autocom/sh.autocom.vim
"}}}
augroup END

augroup algoritmo
   au!
" Definindo a configuração de arquivos algoritmo
"confguração: {{{
"
" evento: se o arquivo não existe em disco
" Carrega configurações pessoais do arquivo, como cores, mapeamento de
" teclado, tipo de comentário e configuração de IDE para o Gvim.
   autocmd BufNewFile *.algoritmo  so $ICPATHCONF/autocom/algoritmo.autocom.vim
"
" evento: se o arquivo não existe em disco
" Carrega um esqueleto do tipo de arquivo que está sendo editado. O
" interessante nesse trexo de código é a segunda linha que ilustra como
" chamar uma função ou executar um comando quando um
" buffer é criado pela primeira vez.
   autocmd BufNewFile         *.algoritmo
   	\ 0r $ICPATHCONF/skeleton/algoritmo.skeleton.vim
   autocmd BufNewFile         *.algoritmo
   	\ exe "%s/_NOME_/" . expand('%:r') . "/g"|
   	\ exe "%s/_DATA_/" . strftime('%d\/%m\/%Y') . "/g"
"
" evento: lendo arquivo (*O ARQUIVO EXISTE EM DISCO*)
" posiciona o cursor na primeira ocorrência da palavra 'início'
   autocmd BufRead            *.algoritmo   1;/início
"
" evento: Entrando e saindo do arquivo  (*O ARQUIVO PODE OU NÃO EXISTIR*)
" ao entrar acrescenta dicionário novo, e retira dicionário de palavras
" ao sair.
   autocmd BufEnter  *.algoritmo   set
   \ dict+=$ICPATHCONF/dict/algoritmo/algoritmo.api
   autocmd BufLeave  *.algoritmo   set
   \ dict-=$ICPATHCONF/dict/algoritmo/algoritmo.api
"}}}
augroup END

augroup MarkupLanguage
   au!
" Linguagens de marcação
" <: (*.htm, *.html, *.xml, *.xhtml,  etc.) :>
"confguração: {{{
"
" evento: se o arquivo não existe em disco
" Carrega configurações pessoais do arquivo, como cores, mapeamento de
" teclado, tipo de comentário e configuração de IDE para o Gvim.
   autocmd BufNewFile,BufReadPre   *.html,*.htm
   			\ so $ICPATHCONF/autocom/html.autocom.vim
   autocmd BufNewFile,BufReadPre   *.xml
   			\ so $ICPATHCONF/autocom/xml.autocom.vim
"
" evento: se o arquivo não existe em disco
" Carrega um esqueleto do tipo de arquivo que está sendo editado
   autocmd BufNewFile   *.xml  read
        		\ $ICPATHCONF/skeleton/xml.skeleton.vim
"
" evento: Entrando e saindo do arquivo  (*O ARQUIVO PODE OU NÃO EXISTIR*)
" ao entrar acrescenta dicionário novo, e retira dicionário de palavras
" ao sair.
" remove dicionário de portugues
   au BufEnter *.\<\(xml\)\|\(x\=html\=\)\>,*.js
   			\ set dictionary-=$ICPATHCONF/dict/portugues/portugues.api
"
" HTML Xml
   autocmd BufEnter  *.\<\(xml\)\|\(x\=html\=\)\>  set
   			\ dict+=$ICPATHCONF/dict/html/tags.api
   autocmd BufLeave  *.\<\(xml\)\|\(x\=html\=\)\>  set
   			\ dict-=$ICPATHCONF/dict/html/tags.api
"
" JavaScript
   autocmd BufEnter  *.js  set
   			\ dict+=$ICPATHCONF/dict/html/mat.api
   autocmd BufLeave  *.js  set
   			\ dict-=$ICPATHCONF/dict/html/mat.api
"
" adiciona dicionário de portugues
   au BufLeave *.\<\(xml\)\|\(x\=html\=\)\>,*.js
   			\ set dictionary=$ICPATHCONF/dict/portugues/portugues.api

"}}}
augroup END

  " **************************************************************************
  " * GVIM                                                                   *
  " * ----                                                                   *
  " *  Manter a compatibilidade de código é mais que necessário para a       *
  " *  edição com o vim. Dessa forma qualquer mudanca de sistema operacional *
  " *  não irá alterar o funcionamento do editor.                            *
  " *                                                                        *
  " **************************************************************************
if has("gui_running") 

" tamanho da janela:
	set lines=65
	set columns=120
	winpos 0 0
"  definição de fonte                                                    
	set guifont=Courier_New:h14:cANSI
"  set guifont=Courier:h15:cANSI

"  Minha cor preferida. 
   call ColoreTerminal(4)
"  Menu  Default 
	source $ICPATHCONF/ide/menu.vim
"-----------------------------------------------------------------------------
	function ActiveDebug()
		if !exists('g:botao')
			call Message('info',"-- Debugador ativo com a tecla <F4> --")
			map <F4> \D1
			let g:botao=1
		else
			call Message('warning',"-- Debugador inativo <F4> Liberada --")
			unmap <F4>
			unlet g:botao
		endif
	endfunction
"-----------------------------------------------------------------------------


" A comfiguração abaixo garante o funcionamento de programas UNIX dentro 
" do gvim. Caso esse tipo de configuração não esja hábilitada teremos os
" seguinte tipos de erros:
" exemplo:
" :echo substitute(system('echo "8*9"|bc'),'\n','',"g")
" (standard_in) 1: illegal character: ^M
" 
" Todavia, se configurado o shell retorna 72 no prompt-vim.

" Set shell to Cygwin bash
set shell=F:\\cygWin\\cygwin-root\\cygwin\\bin\\bash.exe
"set shell=F:\\cygWin\\cygwin-root\\cygwin\\cygwin.bat

" Shell arguments; -c: argument
set shellcmdflag=-c

" Shell redirect; copy stderr to stdout
set shellredir=>%s\ 2>&1

" Shell pipe; copy stderr to stdout
set shellpipe=2>&1\|\ tee

" Shell quote; embed command within quotes
set shellxquote=\"
set shellxquote='
set shellslash
endif
  

"=============================================================================
"D E B U G   E  A L T E R A C O E S   D O   D O C U M E N T O    (VI-IMproved)
"=============================================================================

"                     -- Carrega Debugador --
so $ICPATHCONF/func/debug.vim
if exists('b:DEBUG_LIB')
	if has("gui_running")
  		nnoremap \D1 :call LinhaSelecionada('StatusLine','Cursor')<cr>
	else
  		nnoremap \D1 :call LinhaSelecionada('StatusLine','DiffChange')<cr>
	endif
	map \DB :map <F4> \D1<cr>
"	imap \DB <c-o>\D1
endif
" evento: lendo arquivo (*O ARQUIVO EXISTE EM DISCO*)
" corrige a o índice do arquivo atual editado
autocmd BufRead  .vimrc   1|call IndicePontoVimrc()
                          \|so $ICPATHCONF/autocom/vim.autocom.vim

"carrega o registro a com o índice do arquivo
autocmd BufRead  .vimrc   map <F5> :27,43p<cr>


"=============================================================================
"N O T A S  P O R  V E R S A O                                   (VI-IMproved)
"=============================================================================
"
"
"
"=============================================================================
"A J U D A                                                       (VI-IMproved)
"=============================================================================
"
" Definindo comandos AJUDA e de navegação no documento .vimrc
"
"
"             --  C O M A N D O S  D O  U S U A R I O  --

so $ICPATHCONF/doc/ajudausuario.vim
"cmap ajuda   call AjudaUsuario()<cr>
com -nargs=0 MyAjuda call AjudaUsuario()

"             -- C O R E S --

cab cores call AjudaCores()
"
"=============================================================================
"B I B L I O G R A F I A                                         (VI-IMproved)
"=============================================================================
"
"
"        A.  Mastering Regular Expressions
"            Powerful Techniques for Perl and Other Tools
"            by Jeffrey E.F. Friedl
"            Publisher: O'Reilly & Associates Inc.
"
"
" Essa é a bíblia de expressões regulares, deve ser lido por qualquer um que
" deseje se aprimorar com profundidade no assunto.
"
"
"        B. Guia de Expressões Regulares - by Aurélio Marinho Jargas
"           Publisher: NOVATEC Editora Ltda.
"
"
" Esse livro é o passo inicial para qualquer usuário LINUX que deseja
" maximizar o potencial de seus comandos comandos de linhas.
"
"
"        C. Apostila CURSO PROGRAMAÇÃO PROFISSIONAL EM SHELL
"           Copyright© 2003, 2004 por Aurélio Marinho Jargas
"           Nº Registro na BN: 303.593 Livro: 552 Folha: 253
"
"
" Um dos poucos bons livros sobre SHELL em português que vai além do
" básico. Além de mostrar algumas técnicas de programadores experientes em
" SHELL-SCRIPT
"
"
"        D. Editor Vi - By Roberto Severo de A. Coelho
"           Publisher: NOVATEC Editora Ltda.
"
"
" Esse é único livro sobre VI brasileiro. Apesar de não enfatizar
" com profundidade o potencial do VI é imprescindível a leitura do mesmo,
" por iniciastes e entusiastas do UNIX.
"
"
"        E. Learning the Vi Editor - by Linda Lamb&Arnold Robin
"           Publisher: O'Reilly & Associates Inc.
"
"
" É fundamental a sua leitura para todo aquele que deseja utilizar o Editor
" VI e seus clones de forma eficiente e produtiva.
"
"
"        F.  Site oficial do VIM
"            Mantenedor: Bram Moolenaar <bram@vim.org>.
"            HomePage do vim na WWW:
"            http://www.vim.org/
"
"
" É a principal fonte de atualizações do editor VIM, além de centenas de
" exemplos de escripts e tutoriais sobre os mais diversos tópicos do editor.
"
"
"=============================================================================
"C R E D I T O S                                                 (VI-IMproved)
"=============================================================================
" Esse arquivo dotfile do VIM foi em quase toda sua plenitude baseado no
" arquivo .vimrc de Aurelio Marinho Jargas.
"
" Aurélio Marinho Jargas é desenvolvedor de software livre tem dois livros
" publicados e escreve com regularidade artigos sobre ferramentas LINUX-like
" e sobre a comunidade com muito bom humor.
"
" Dentre os softwares temos txt2tags, RAC, txt2regex e SedSoKoban
"
" Com relação aos livros temos O Guia de Expresses Regulares e  Apostila
" do Curso de Shell.
"
"SITE:http://aurelio.net/
"
"
" ,----------------[ http://www.del.ufrj/~ivanczar/ ]------------------------.
" |  1. Sempre que você pegar um trecho de código de alguém da comunidade    |
" |     informe seu nome, site e mail. Pois uma comunidade é construída com  |
" |     boas relações de seus participantes.                                 |
" |                                                                          |
" |  2. Desencorajo qualquer cópia de documento não autorizada pelo autor da |
" |     obra ou editora.                                                     |
" |                                                                          |
" |  3. A compra de bons livros de autores nacionais deve ser estimulada pela|
" |     comunidade. Como o incentivo aos mesmos que continuem a utilizar seu |
" |     talento e perspicácia na produção de livros de qualidade em bom      |
" |     português.                                                           |
" |                                                                          |
" |                                                                          |
" |      Ivan Carlos Da Silva Lopes                                          |
" |                                                                          |
" `--------------------------------------------------------------------------/
"
"
"=============================================================================
"D I C A S                                                       (VI-IMproved)
"=============================================================================
"
" 1. Lendo manpage:
" $ man assunto | col -b | vim -
" - no gvim (modo Ex)
" 		:new|read!man tar|col -b
"
" 2. Abrir todos os arquivos que contenham uma determinada palavra.
" $ vim `fgrep -l <palavra> *.ext`
"
" 3. Mapeamento para inserir linha com repetição de char
"    :map - <Esc>o<Esc>78a-<Esc>
"    :let @q="*"|normal i" 76"qp
"
"
" 4. Mapeamento para Ctrl-key
"
"    exemplo01: mapeando a tecla Ctrl-t
"    :map   iOla Mundo
"
"    exemplo02: mapeando a tecla Ctrl-a
"    :map   iOla Mundo
"
"    exemplo03: mapeando a tecla Ctrl-a
"    :map <c-a> iOla Mundo
"
"    exemplo04: mapeando a tecla Ctrl-a
"    :map <char-1>  iOla Mundo
"
"
" 5. Filtrando comandos internos.
"    Exemplo01:
"    1,10m$|g/Essas/ p
"    Exemplo02: move bloco de texto para última linha do arquivo e substitui
"    'Essas' por 'Aquelas' dentro do bloco.
"    1,10m$|s/Essas/Aquelas/g
"
" 6. Contando os padrões encontrados na edição.
"    :let i=0|%g/{padrao}/let i=i+1
"    :echo i
"
" 7. Mapeamento.
"    - Qual o mapeamento de <F4> ? :map <F4>
"    - Quais os mapeamentos dos comandos que iniciam por ; ? :map ;
"
"             mapea       modo     limpar          exemplo
"             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"             map          n       unmap           map <F5> :Ex<cr>
"     +-----> map!/imap    i       unmap!          imap ff  File folder
"     |       iabb[rev]    i       una[bbreviate]  iabbr oi oiMundo
"     +-----> cmap         lc      cunmap          cmap oi echo "oi mamae"
"     |       cab          lc      cuna            cab oi  echo "Oi"
"     |       --------------------------------------------------------
"     |
"     +--------------- não é necessário <spaço> e/ou [enter] após comando.
"
"  n/c - modo normal ou modo de comando
"  i   - modo de inserção
"  lc  - modo de linha de comando
"  v   - modo visual
"  R   - Reposição
"  B   - Busca
"
" sintaxe : comando-Mapeador {key[[key]...]} {comando[s]}
"
"    - Formato define-mapeia ou mapeamento referenciado
"
" sintaxe:
" nnoremap    \{nomeExterno}              {comando[s]}
" {map-modo01} {combinação-tecla[s]02}   \{nomeExterno}
" {map-modo02} {combinação-tecla[s]03}   \{nomeExterno}
" {map-modo03} {combinação-tecla[s]04}   \{nomeExterno}
"
"        exemplo:
"           nnoremap \key :let @m="oi gente"<cr>:put m<cr>
"           nmap <F5> \key
"           imap <F5> <c-o>\key
"
"  abreviacoes
"  -----------
"
"      ab         - mostra todas as abreviações
"      abc[lear]  - limpa todas as abreviações
"      iab        - mostra todas as abreviações do modo de inserção
"      iabc[lear] - limpa todas as abreviações do modo de inserção
"      cab        - mostra todas as abreviações do modo de comando
"      cabc[lear] - limpa todas as abreviações do modo de comand
"
"
" 8. Movimentação por links:
"
"  	movimentação   '{char}
"  	para linkar    :<range> mark {char}
"
" 9. Lendo man page ou help de programas externos:
"    read !man dc|col -b
"    read !bc --h
"
" 10. Convertendo formato entre janelasr:
"
"	   - convertendo do formato horizontal para o vertical.
"
"     W|W|W
"para
"     W
"     W
"     W
"
"                     :windo wincmd K
"
"
"	   - convertendo do formato vertical para o horizontal.
"
"     W
"     W
"     W
"para
"     W|W|W
"
"                    :windo wincmd H
"
" 11. Numerando linhas selecionadas
"
"	   - usando um comando linux externo:
"
"       :'<,'>!cat -n
"       :3,10!cat -n|tr '^I' '-'
"
"
"     - usando Vim-Script:
"
"       - com variável
"             a) let  i=0|'<,'>g/^/let i=i+1|s//\=i/g
"             b) let  i=0|'a,'eg/^/let i=i+1|s//\=i/g
"             c) let  i=0|2,200g/^/let i=i+1|s//\=i/g
"
"       - com registro
"             a) let  @s=0|'<,'>g/^/let @s=@s+1|s//\=@s/g
"             b) let  @s=0|'a,'eg/^/let @s=@s+1|s//\=@s/g
"             c) let  @s=0|2,200g/^/let @s=@s+1|s//\=@s/g
"
"       - com funcoes do Vim
"             a) '<,'>s/^/\=(line('.') - line("'<") + 1)/g"
"             b) 's,'qs/^/\=(line('.') - line("'s") + 1)/g"
"             c) '20,46s/^/\=(line('.') - 20 + 1)/g"
"
"       - com minhas próprias funcoes
"
"             a) '<,'>s/^/\=INC(1)/g"
"
"
"  +====================+====================+====================+
"  |    valor           |  :echo (valor)     | :echo strlen(valor)|
"  +====================+====================+====================+
"  | 987654321 % 10     |           1        |      1             |
"  | 987654321 % 100    |          21        |      2             |
"  | 987654321 % 1000   |         321        |      3             |
"  | 987654321 % 10000  |        4321        |      4             |
"  | 987654321 % 100000 |       54321        |      5             |
"  | 987654321 % 1000000|      654321        |      6             |
"  +--------------------+--------------------+--------------------+
"             :let c=3|let s=20|exec "normal i+ ".c."i".Espaco(s,'-')."+"
"              insere a linha da tabele acima
"
"
" 12. invertendo linhas em arquivo:
"
"     :'<,'>g/^/m '<
"     :25,67g/^/m 25
"
" 13. Executando comando externo no modo de comando:
"
" a)
"     no modo de comando de linha
"     :let @a=".!seq 5"
"     executando o comando contido no registro a:
"     @a
"
" b)
"     no modo de comando de linha
"     :let @s=":%!sort -u"
"     executando o comando contido no registro s:
"     @s
"
" 14. Metacaracteres especiais:
"
"
"    meta   exemplo              Casamentos
"   +~~~~~+~~~~~~~~~~~~~~~~~+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+
"   |     |                 |                                                |
"   | \@= | Buf\(Read\)\@=  | BufReadPost, BufRead, BufReadPre,BufReadPost   |
"   |     |                 |                                                |
"   |     |                 | siguinificado:casa 'Buf' se 'Buf' sucedido     |
"   |     |                 | por 'Read'                                     |
"   +-----+-----------------+------------------------------------------------+
"   |     |                 |                                                |
"   | \@! | Buf\(Read\)\@!  | BufWritePost, BufNewFile, BufWritePre          |
"   |     |                 |                                                |
"   |     |                 | siguinificado:casa 'Buf' se 'Buf' não for      |
"   |     |                 | sucedido por 'Read'                            |
"   +~~~~~+~~~~~~~~~~~~~~~~~+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+
"   |     |                 |                                                |
"   |\@<! | \(Read\)\@<!Post| BufWritePost, FileWritePost, FileAppendPost    |
"   |     |                 |                                                |
"   |     |                 | siguinificado:casa 'Post' se 'Post' não for    |
"   |     |                 | precedido por 'Read'                           |
"   +-----+-----------------+------------------------------------------------+
"
"
" 15. Capturando saída de comando externo como string:
"
"     let a=system('ls')
"     echo  matchstr(system('cygpath -m /'), "^.*\\ze\n") . '/'
"     echo  substitute(system('gcc -v'),'\s\+','\n','g')
"
" 16. Comando duplos:
"
"   - [ indentexpr, indentexpr]
"   exemplo:
" 		  setlocal indentexpr=GetPascalIndent()
" 		  setlocal indentkeys+==end,=else,=type,=var,=Begin
"
"   - [ grepprg, grepformat]
"	 exemplo:
"		setlocal grepprg=lid\ -Rgrep\ -s
"		setlocal grepformat=%f:%l:%m
"
"   - [ makeprg, errorformats]
"	 exemplo:
"	   let &l:makeprg
"     set makeprg=make\ #<.o
"     set efm=%EError\ %n,%Cline\ %l,%Ccolumn\ %c,%Z%m
"     set makeprg=latex\ \\\\nonstopmode\ \\\\input\\{$*}
"     let &mp = 'latex \\nonstopmode \\input\{$*}'
"     set makeprg=gcc\ -o\ $*\ $*
"     set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
"
" 17. Fechando blocos de código:
"		let  &foldmarker="if,endif"|echo &foldmarker
"
" 18. Isere string em linha especifica:
"
"     :call setline(5,strftime("%d.%m.%Y  %X"))
"
" 19. Isere string em linha especifica:
"     :let id="valor"
"     :put =expand(id)
"
"     :let @g="Eu amo o VIM"
"     :exe 'normal 20"gp'
"     :exe "normal 200\p"
"     :exe "normal \iOi Caroline"
"     :'<,'>s/^/\='U'.Espaco(9,'k')/g
"     :'<,'>s/^/\='<'.Espaco(9,'-').'>'/g
"     :let m="<right>"|exe 'normal '.10.'i'.m
" 20. Deletando
"
"     : {linha} delete {contador}
"
"     por exemplo : n delete 5
"
"     irá deletar as linhas n,n+1,...,n+5
"
"
"    tipos de variáveis
"    ===================
"
"   aviso aos navegantes:
"   &texwidth  é o valor armazenado em texwidth
"   :set texwidth
"    78
"   :let b:a=texwidth      ERRADO
"   :let b:a=&texwidth     CERTO
"   echo (b:a)
"   78
"
"   :let &texwidth=25      CERTO
"   :set texwidth
"   45
"
" 	 selecione 12 < colune < 18 e linha <10
"   exe '/\%>' . '12c' . '\&.*' . '\%<18c' . '\&.*' . '\%<10l'
"
"
" 21. gravando o histórico da linha de comandos em um arquivo
" 
" $fc -l cp > ultimos-comandos vi lastcommands$ source lastcommands
"  |
"  |
"  +------ O comando fc edita o shell com seu editor preferido.
"
"  um exemplo interessante é escrever na linha de comando `fc`
"  $fc
"  
"  $fc -s     -- executa o último comando editado na linha de comando
"  $fc -s gcc -- executa o último comando `gcc` editado na linha de comando
"
"
" 22. salvando como
"  para tanto usamos o comando w (write)
"
"
"exemplo:
":2,8w nome_noivo_Arquivo.txt
"
"salvando da linha 2 a 8 no arquivo nome_noivo_Arquivo.txt
"
"exemplo2:
"
":g/pattern/ .+2 !>> nome_noivo_Arquivo.txt
"
"salva as linhas que casarem com a combinaço pattern,
"sendo assim as mesmas 2 pontos abaixo.
"
"
"
" 23. Alteração em tempo de execução  
"
"  vi -c":%s/include/Bala da GOMA/g"   max.c
"  
" 24. cidificando 
"  map <F12> ggVGg? 
"
"Folding :
"
"  i. Folding Markers := {{{ }}}
" ii. Close One Fold := zc
"iii. Open One Fold := zv
" iv. Open All Fold := zn
"  v. Close All Fold := zm
"
"Move Around :
"
"  i. First Line := :0
" ii. Last Line := :$
"iii. Move To Line := :XX (XX is for Line Number)
"
" nmap <c-s> :w<CR>
" vmap <c-s> <esc><c-s>
" imap <c-s> <esc><c-s>
"
" The F2 series of mappings are different; they only write if needed
" (performing an update) AND return you to where you were:  insert mode,
" visual selection etc.
"
" nmap <f2> :update<cr>
" vmap <f2> <esc><f2>gv
" imap <f2> <c-o><f2> 
"
"=============================================================================
" vim: set fdm=marker tw=78:ts=3:
