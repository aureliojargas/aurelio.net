" https://aurelio.net/doc/coluna
" coluna do aurelio 09 [2001-06-28]
" vim (um vimrc diferente)
"
" original em https://aurelio.net/doc/coluna/coluna-09.html
"
" olás. creio que o  vim  não precisa de  apresentação não é mesmo? pois
" bem,  então que tal explorarmos aquele mundo  misterioso que o arquivo
" de configração  ~/.vimrc  nos apresenta? o que é um vimrc?  oras, este
" texto todo é um vimrc!  copie-o para seu  $HOME  e incremente seu vim.
" ah! aproveite e leia este texto direto no vim, para ficar colorido.
"
" como já pudemos perceber, linhas que começam com aspas são comentários
" e nelas podemos soltar o verbo e colocar todo tipo de  informação útil
" para a manutenção deste arquivo. então vamos lá.
"
" para aumentar a esperteza e memorização do vim, podemos ter um arquivo
" ~/.viminfo que guardará dados úteis como seu histórico de pesquisas /,
" linha de comando :, marcas `, registradores, entre outros. então com o
" viminfo é  possível copiar uma  linha qualquer (yy),  sair do arquivo,
" abrir um OUTRO arquivo e colar (p) aquela linha copiada anteriormente.
" você pode inclusive nesse intervalo  desligar a máquina e ficar um mês
" de férias, que ao voltar o vim  ainda saberá qual foi a linha copiada.
" não tem contra-indicações. USE!
"
" a segunda linha é uma gambiarra para que ao abrir um arquivo, o cursor
" já fique na  posição que estava na  última vez que ele foi  editado. o
" viminfo guarda a posição de TODOS os arquivos que você editou.
"
set viminfo='10,\"30,:20,%,n~/.viminfo
au BufReadPost * if line("'\"")|execute("normal `\"")|endif

" o vim possui uma linguagem de programação própria,  onde podemos fazer
" funções, e até aplicativos inteiros, como o  vine (leitor de e-mail) e
" o jogo sokoban.vim. mais info sobre o assunto consulte www.vim.org.
"
" mas, como já  temos que fazer  nossos próprios programas, temos opções
" mais acessíveis para automatizar tarefas,  como o mapeamento. aqui vai
" um mapeamento  exclusivo do  modo de inserção (note o i no começo) que
" faz a  função de completação automática  de palavras, procurando-as no
" próprio arquivo. é fácil de usar e nos poupa tempo, além da certeza de
" que a palavra completada está grafada corretamente. então temos:
"
" F7: completa uma palavra
" F8: dá seqüência a essa palavra
"
" os mapeamentos foram  gravados nas teclas F7 e F8,  mas poderia ser em
" qualquer outra. suponha que você se chame Zózimo Gwinch Wurstalinewski
" e digitou seu nome numa parte do texto. depois em outra parte do mesmo
" texto, você precisa colocar seu nome novamente. ê trabalheira.
"
" mas como você  tem esse supermapeamento,  simplesmente digita Zó<F7> e
" surpresa! seu primeiro nome foi completado. e para fazer o resto, você
" continua completando as palavras seguintes com a tecla <F8>, então com
" Zó<F7><F8><F8>, lá está seu nome completo. imbatível.
"
" isso é muito muito útil ao programar, completando nomes de variáveis e
" funções,  geralmente longos e  difíceis,  e que você repete  em várias
" partes do programa.
"
imap <F7> <c-n>
imap <F8> <c-x><c-n>

" e se você tem certos textos  que sempre tem que ficar  digitando, como
" seu nome completo, seu email, seu endereço,  faça abreviações, que são
" completadas automaticamente enquanto você as digita.
"
" use abreviações para textos normais, para comandos use mapeamentos.
"
iab zgw Zózimo Gwinch Wurstalinewski
iab @@  zozimo@wurstalinewski.com.br

" e como o capitalismo nos obriga a produzir em velocidade insalubre, ao
" salvar e/ou sair de um arquivo, é comum na pressa digitar o `w` ou `q`
" em maiúsculas, pois você ainda não soltou o dedo do  shift que apertou
" para fazer os dois pontos :.
"
" mas não se desespere!  até para os problemas econômicos mundiais o vim
" tem a solução! basta usarmos abreviações para a linha de comando (Cab)
"
cab W  w
cab Wq wq
cab wQ wq
cab WQ wq
cab Q  q

" um mapeamento é na verdade uma  seqüência de teclas que você apertaria
" normalmente no vim,  para fazer a tarefa.  o ENTER é representado  por
" <cr>, um  crtl+y vira <c-y> e se o  mapeamento exceder uma linha, você
" pode quebrá-la e começar a próxima com um escape \.
"
" um cuidado especial  deve ser tomado ao nomear um mapeamento, para não
" usar  letras ou nomes  que já são  comandos do vim.  para evitar isso,
" sempre inicie o nome de um  mapeamento com uma vírgula. no exemplo, ao
" digitar ,d no modo de comando (não é inserção) aparecerá a data atual.
"
map ,d :r!date<cr>
      \:s/ \(...\) \(..\).*\(....\)$/, \2 de \1 de \3/<cr>
      \:nohl<cr>

" e tem uma dica boa para os  programadores  de plantão. comentários num
" programa são  excelentes, mas  na hora da  sua manutenção,  eles podem
" atrapalhar, pois você queria ver só o código.
"
" para resolver este problema, vamos fazer um  truque no vim. que tal se
" pintarmos os comentários de preto para que fiquem invisíveis?  podemos
" fazer isso redefinindo o componente da cor da sintaxe.  ah! e quem usa
" fundo branco (argh) vai ter que trocar `black` por `white`.
"
" e como somos chiques ainda criamos uma função vim pra fazer o serviço.
" a CommOnOff()  oculta/mostra os comentários, alternando.  o resumão do
" que ela faz é: se a variável global  'hiddcomm'  não existir, a cria e
" oculta os comentários. se já existir, restaura os comentários. por fim
" definimos um mapeamento esperto no F11 para chamar nossa função.
"
" dica: se você está lendo este arquivo no vim, experimente agora mesmo!
"   :so %
"   F11
"   F11
"
fu! CommOnOff()
  if !exists('g:hiddcomm')
    let g:hiddcomm=1 | hi Comment ctermfg=black guifg=black
  else
    unlet g:hiddcomm | hi Comment ctermfg=cyan  guifg=cyan term=bold
  endif
endfu
map <F11> :call CommOnOff()<cr>

" e já que estamos mexendo com a sintaxe,  que tal trocar a cor do texto
" daquela seleção que aparece quando você procura algo com o comando / ?
" é fácil, basta definir a cor do componente da sintaxe. ah sim, a opção
" hls (veja abaixo) deve estar ativa.
"
" você pode colocar as cores que quiser, em inglês. note que é ctermBG e
" FG, de  background e foreground  (fundo e letra). e veja  também que o
" IncSearch (busca enquanto você digita) é invertido!
"
hi    Search ctermbg=green ctermfg=black
hi IncSearch ctermbg=black ctermfg=cyan

" no vim temos diversas opções para  modificar seu comportamento através
" do comando set. para ver  todas as opções  disponíveis, faça :set all.
" diversas  opções já vêem  ligadas por  padrão, então vamos  ver apenas
" algumas mais diferentes.
"
" é sempre bom associar a abreviação da  opção com o nome em inglês para
" ficar mais fácil a  memorização.  no caso das opções de busca  abaixo,
" seus nomes completos são:
"   IncrementedSearch, HighLightedSearch, IgnoreCase e SmartCaSe
"
set is hls ic scs  "opções espertas de busca
set sm             "ShowMatch: mostra o início do bloco recém fechado
set sw=1           "ShiftWidth: número de colunas para o comando >
set ruler          "régua: mostra a posição do cursor
set shm=filmnrwxt  "SHortMessages: encurta as mensagem da régua
set wildmode=longest,list  "para completação do TAB igual ao bash

" a configuração  necessária para que as  cores funcionem no  modo texto
" geralmente já é feita no  vimrc do sistema, mas caso ela não esteja lá
" aqui estão as linhas mágicas que trarão a alegria das cores de volta a
" sua vida:
"
set background=dark
if has("terminfo")
  set t_Co=8
  set t_Sf=[3%p1%dm
  set t_Sb=[4%p1%dm
else
  set t_Co=8
  set t_Sf=[3%dm
  set t_Sb=[4%dm
endif

" mas como acima só  dissemos ao vim 'você pode usar cores', agora falta
" dizermos: 'use cores'. este comando liga a  sintaxe, que é responsável
" por,  dependendo do tipo  de arquivo,  reconhecer e colorir  as várias
" estruturas do texto, como por exemplo <b>tags</b> num HTML.
"
syn on

" outra funcionalidade extremamente  interessante é o autocomando, que é
" executado  automaticamente  dependendo do  nome ou tipo do arquivo, no
" seu carregamento ou saída do editor.
"
" se você tem um arquivo com uma extensão qualquer, como .xyz e quer que
" o vim o interprete como um arquivo HTML,  diga para o vim configurar o
" ft (FileType)  ao abrir um arquivo novo  (BufNewFile)  ou já existente
" (BufRead) com essa extensão.
"
au BufNewFile,BufRead *.xyz set ft=html
"
" ou ainda,  se for um arquivo  de um tipo  já reconhecido pelo vim, use
" diretamente a opção FileType. vamos usar de exemplo a linguagem python
" onde os TABs indicam os blocos de comandos, então é legal `vê-los`.
"
" para isso definimos uma  regra rápida de sintaxe chamada `pythonTAB` e
" a ela associamos a cor azul. além disso definimos algumas opções com o
" comando set e  para fechar,  trocamos a cor  das "strings" para verde,
" porque aquele rosinha é muito palha.
"
au FileType python syn match pythonTAB '\t\+'
au FileType python hi pythonTAB ctermbg=blue
au FileType python set ts=4 tw=80 noet
au FileType python hi pythonString ctermfg=darkgreen

" e p-p-por hoje é só p-pessoal.
"
" --
" este texto pode ser copiado livremente na íntegra ou em parte, desde que
" indicado o endereço do original: https://aurelio.net/doc/coluna
