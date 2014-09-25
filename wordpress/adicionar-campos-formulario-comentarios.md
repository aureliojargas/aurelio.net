---
author: aurelio
date: 2011-04-15
layout: "2014"
slug: adicionar-campos-formulario-comentarios
permalink: wordpress/adicionar-campos-formulario-comentarios/
title: 'WordPress: Como adicionar campos no formulário de comentários'
wordpress_id: 2812
---

É possível adicionar campos novos no formulário de comentários do WordPress, além dos tradicionais Nome, Email, Site e Comentário. Que outro tipo de informação você quer saber sobre os seus leitores? Pode ser o login do twitter, a idade, o sexo, número do telefone residencial, celular, ou cidade e o estado onde moram.

Adicionar campos não é um processo muito fácil, mas também não requer diploma em TI para executar :) Acompanhe com atenção que em poucos minutos estará tudo funcionando em seu blog.

Há quatro passos a serem executados:

  1. Adicionar o campo no formulário de comentários
  2. Verificar o que o usuário digitou no campo
  3. Salvar no banco de dados o conteúdo do campo
  4. Mostrar o conteúdo do campo, seja no backend (administração), na área de comentários ou ambos.

Nos exemplos seguintes, vou mostrar como adicionar dois campos ao formulário: cidade e estado. Para ficar mais elegante, o campo Estado será um menu que lista todos os estados brasileiros. Assim:

![Formulário WordPress com campos para Cidade e Estado](http://aurelio.net/img/wp/formulario-cidade-estado.png)


## Passo 1 - Adicionar o campo no formulário

Abra o arquivo functions.php de seu tema e adicione este código no final:

```php
add_filter('comment_form_default_fields', 'adiciona_campos');

function adiciona_campos($campos) {

    $campos['cidade'] = 'conteúdo HTML';
    $campos['estado'] = 'conteúdo HTML';

    return $campos;
}
```

Não se preocupe (ainda) com a parte 'conteúdo HTML', isso colocaremos daqui dois parágrafos. Mas olhando este esqueleto, perceba que o funcionamento é simples, similar ao procedimento de [remover campos](http://aurelio.net/wordpress/remover-campos-formulario-comentarios/), porém preenchendo em vez de esvaziar.

A primeira linha liga a nossa função `adiciona_campos()` com o filtro responsável por alterar os campos padrão do formulário. A função recebe e retorna um array `$campos`, que contém os campos do formulário. Mas antes de retornar o array, é claro, faremos a mágica de adicionar os campos que precisamos: cidade e estado.

Tenha em mente que `$campos` é um array normal do PHP, onde cada chave representa um campo do formulário e seu conteúdo contém o código HTML completo para mostrar o campo em questão. No caso de um campo de texto como Cidade, é uma tag P que dentro tem um LABEL e um INPUT, veja:

```php
$campos['cidade'] =  '' .
    '<p class="comment-form-cidade">' .
        '<label for="cidade">Cidade</label> ' .
        '<span class="required">*</span>' .
        '<input id="cidade" name="cidade" type="text" value="' .
            esc_attr( $commenter['comment_cidade'] ) .
        '" size="30"' . $aria_req . ' />' .
    '</p>';
```

Você pode copiar e colar esta parte do código dentro de sua função `adiciona_campos()` e trocar a palavra _cidade_ por _idade_ ou _telefone_, por exemplo. Crie tantos campos quantos precisar, basta repetir o código. Se o campo for de preenchimento opcional, basta remover a linha com a tag SPAN, responsável por colocar o asterisco que indica o preenchimento obrigatório.

> <del>**Nota:** Apesar do asterisco ali no código, eu ainda não sei como forçar a verificação do campo. O comentário vai ser aprovado mesmo que o campo Cidade esteja vazio. Quando eu aprender como faz, atualizarei este texto.</del> Aprendi. Veja o novo passo 2 :)

Para preencher o código HTML do campo Estado é a mesma coisa, porém, como quero fazer um menu com todos os estados brasileiros, usarei um SELECT no lugar do INPUT. Só isso.

Veja como ficou o código final, completo:

```php
add_filter('comment_form_default_fields', 'adiciona_campos');

function adiciona_campos($campos) {

    $campos['cidade'] = '' .
        '<p class="comment-form-cidade">' .
            '<label for="cidade">Cidade</label> ' .
            '<span class="required">*</span>' .
            '<input id="cidade" name="cidade" type="text" value="' .
                esc_attr( $commenter['comment_cidade'] ) .
                '" size="30"' . $aria_req . ' />' .
        '</p>';

    $campos['estado'] = '' .
        '<p class="comment-form-estado">' .
            '<label for="estado">Estado</label> ' .
            '<span class="required">*</span>' .
            '<select id="estado" name="estado">' .
                '<option value="">--</option>' .
                '<option value="AC">AC - Acre</option>' .
                '<option value="AL">AL - Alagoas</option>' .
                '<option value="AM">AM - Amazonas</option>' .
                '<option value="AP">AP - Amapá</option>' .
                '<option value="BA">BA - Bahia</option>' .
                '<option value="CE">CE - Ceará</option>' .
                '<option value="DF">DF - Distrito Federal</option>' .
                '<option value="ES">ES - Espírito Santo</option>' .
                '<option value="GO">GO - Goiás</option>' .
                '<option value="MA">MA - Maranhão</option>' .
                '<option value="MG">MG - Minas Gerais</option>' .
                '<option value="MS">MS - Mato Grosso do Sul</option>' .
                '<option value="MT">MT - Mato Grosso</option>' .
                '<option value="PA">PA - Pará</option>' .
                '<option value="PB">PB - Paraíba</option>' .
                '<option value="PE">PE - Pernambuco</option>' .
                '<option value="PI">PI - Piauí</option>' .
                '<option value="PR">PR - Paraná</option>' .
                '<option value="RJ">RJ - Rio de Janeiro</option>' .
                '<option value="RN">RN - Rio Grande do Norte</option>' .
                '<option value="RO">RO - Rondônia</option>' .
                '<option value="RR">RR - Roraima</option>' .
                '<option value="RS">RS - Rio Grande do Sul</option>' .
                '<option value="SC">SC - Santa Catarina</option>' .
                '<option value="SE">SE - Sergipe</option>' .
                '<option value="SP">SP - São Paulo</option>' .
                '<option value="TO">TO - Tocantins</option>' .
            '</select>' .
        '</p>';

    return $campos;
}
```

Nesse ponto você já pode conferir em seu blog e os campos vão aparecer em seu formulário. Nem foi tão difícil, né?

Mas eles ainda são campos burros, que não guardam o que o visitante digitar. Se você preencher o formulário completo e enviar, verá que o comentário será gravado, mas as informações adicionais (cidade, estado) serão perdidas. Para evitar que isso aconteça, vamos ao próximo passo.


## Passo 2 - Verificar os dados

Num mundo perfeito, este passo seria desnecessário. Mas infelizmente você não pode confiar cegamente em seus usuários.

  * O usuário esqueceu de preencher um campo obrigatório?
  * O usuário colocou um valor incorreto no campo?
  * O usuário está tentando hackear o blog com um comentário malicioso?

Primeiro precisamos da verificação mais básica de todas, conferir se por acaso o usuário se esqueceu de preencher algum campo obrigatório. Ainda no arquivo functions.php, basta adicionar mais algumas linhas mágicas:

```php
add_filter('preprocess_comment', 'checa_campos');

function checa_campos($commentdata) {

    // Verifica se os campos obrigatórios estão preenchidos
    if (!$_POST['cidade']) wp_die('Faltou preencher a CIDADE');
    if (!$_POST['estado']) wp_die('Faltou preencher o ESTADO');

    return $commentdata;
}
```

O procedimento é o mesmo que fizemos no passo anterior: criar uma função nova e ligá-la a um filtro pré-definido do WordPress. Este filtro `preprocess_comment` é acionado quando o usuário envia o formulário, então aqui você tem a chance de fazer algo antes que o comentário seja gravado no banco de dados.

A função é bem simples, ela verifica se por acaso a cidade ou o estado estão vazios, e caso estejam, mostra uma mensagem de erro para o usuário. Alguns detalhes:

  * O array `$_POST` guarda todos os dados do formulário.
  * A função `wp_die()` interrompe a execução do WordPress e mostra uma mensagem de erro para o usuário.
  * O array `$commentdata`, que a função recebe e retorna, pode ser ignorado pois não precisamos mexer nele.

Tudo bem, com isso os campos vazios já não passam mais. Mas se em vez do nome da cidade o usuário digitar algum código malicioso para tentar confundir o sistema e invadir o seu blog?

Dica para a vida: **Nunca confie nos dados digitados pelo usuário, NUNCA!**

Lembre-se que além, de usuários incautos, há também os hackers e os spammers. Você nunca sabe qual deles está usando seu formulário, então deve se precaver. Você deve detectar e remover qualquer tentativa de burlar as regras.

Aquela função `checa_campos()` que acabamos de criar para verificar se o campo é vazio é o lugar ideal para colocar todas as verificações que você precisa fazer antes confiar no conteúdo do usuário. E quer saber uma notícia muito boa? A equipe do WordPress já deixou prontas para uso as ferramentas que verificam e limpam o texto do usuário. Acompanhe:

```php
add_filter('preprocess_comment', 'checa_campos');

function checa_campos($commentdata) {

    // Remove possíveis textos maliciosos
    $_POST['cidade'] = apply_filters('pre_comment_author_name', $_POST['cidade']);
    $_POST['estado'] = apply_filters('pre_comment_author_name', $_POST['estado']);

    // Verifica se os campos obrigatórios estão preenchidos
    if (!$_POST['cidade']) wp_die('Faltou preencher a CIDADE');
    if (!$_POST['estado']) wp_die('Faltou preencher o ESTADO');

    return $commentdata;
}
```

Há um filtro chamado `pre_comment_author_name` que é usado para limpar o conteúdo do campo Nome. Podemos usá-lo para limpar também os nossos campos novos, e é isso que o código anterior faz. Entre outras faxinas, este filtro remove códigos HTML e escapa caracteres especiais como `<` e `&`.

Se você precisar de algum outro tipo de verificação, basta adicionar ali dentro desta função. Por exemplo, se você tem um campo chamado Idade, deve verificar se o usuário digitou mesmo um número. Ou ainda, se tiver um campo CPF em seu formulário, pode usar [expressões regulares](http://aurelio.net/regex/) para verificar se o formato do número está correto. E caso encontre qualquer problema, use a `wp_die()` para mandar uma mensagem ao usuário.

Agora que o formulário está validado, estamos prontos para o próximo passo.


## Passo 3 - Salvar no banco de dados

Novamente em seu functions.php, agora adicione este código mágico no final:

```php
add_action('comment_post', 'salva_campos', 1);

function salva_campos($comment_id) {
    add_comment_meta($comment_id, 'cidade', $_POST['cidade']);
    add_comment_meta($comment_id, 'estado', $_POST['estado']);
}
```

Mais simples impossível. Criamos uma função nova `salva_campos()` que é ligada ao filtro comment_post, assim ela será chamada no momento em que os dados do comentário forem enviados.

A função `add_comment_meta()` do WordPress se encarrega de guardar os dados de nossos campos adicionais lá no banco de dados. O segundo argumento será o nome do campo no banco de dados e o terceiro é o seu conteúdo, ou seja, o que o usuário digitou, obtido diretamente de `$_POST`.

> Aconselho usar sempre o mesmo nome, tanto no formulário (ID da tag INPUT ou SELECT) quanto no banco de dados. Isso evita dores de cabeça.

Para cada campo novo que você adicionar ao formulário, adicione também uma linha nova dentro dessa função, para que seus dados sejam salvos.

Tá, mas e aí? Para testar, você foi lá, preencheu tudo e enviou o comentário. Como saber se os dados foram realmente gravados no banco de dados?

  * Se você for nerd, acesse o MySQL e veja os últimos registros da tabela `wp_commentmeta`.
  * Se você não for nerd, vai ficar no escuro por enquanto, mas o próximo passo vai te ajudar :)


## Passo 4 - Mostrar na tela

Aqui é um ponto onde cada um pode seguir um caminho diferente.

  * **Dados privados:** Se você criou campos adicionais no formulário para coletar informações pessoais sobre seus leitores, não vai querer divulgá-las, então elas devem estar acessíveis somente para você, na interface de administração do WordPress.
  
  * **Dados públicos:** Se os campos adicionais forem públicos, como por exemplo a conta do twitter do visitante, é legal mostrar junto com o próprio comentário.

Pública ou privada, o método para obter a informação é o mesmo: basta usar a função `get_comment_meta()`, passando o ID do comentário e o nome do campo que você quer saber o conteúdo. Em nosso exemplo, este é o código para obter o nome da cidade e a sigla do estado e guardá-los em variáveis:

```php
$cidade = get_comment_meta(get_comment_ID(), 'cidade', true);
$estado = get_comment_meta(get_comment_ID(), 'estado', true);
```

> Nota: Sem aquele `true` no final, o valor seria retornado dentro de um array, o que neste caso, não ajudaria em nada.

E pronto, agora que está numa variável, é você quem decide onde quer mostrá-la. Basta editar o template de seu tema, mais especificamente o comments.php.

Beleza? É isso então.

Falou!

Tchau!

...

Ué, tá aqui ainda?

Tá bom, tá bom, eu mostro um código pronto :)

```php
// functions.php
// Mostra a cidade e o estado (no backend) na lista de comentários
// O filtro comment_text serve para alterar o texto do comentário

if (is_admin()) {

    add_filter('comment_text', 'mostra_campos');

    function mostra_campos($texto_comentario) {

        $cidade = get_comment_meta(get_comment_ID(), 'cidade', true);
        $estado = get_comment_meta(get_comment_ID(), 'estado', true);

        if ($cidade || $estado) {
            return "Cidade: $cidade - $estado\n\n$texto_comentario";
        }

        return $texto_comentario;
    }
}
```

**Atualização:** Veja neste outro artigo [como mostrar os campos adicionais no app do WordPress para iPhone/iPad](http://aurelio.net/wordpress/ios-comentarios-meta/).

## Detalhe

  * Esse esquema só funciona à partir do WordPress versão 3.0.


## Referência

  * <http://codex.wordpress.org/Theme_Development#Functions_File>
  * <http://codex.wordpress.org/Function_Reference/comment_form>
  * <http://codex.wordpress.org/Function_Reference/add_action>
  * <http://codex.wordpress.org/Function_Reference/add_filter>
  * <http://codex.wordpress.org/Function_Reference/wp_die>
  * <http://codex.wordpress.org/Plugin_API>

