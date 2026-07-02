---
title: Minhas primeiras impressões da linguagem Swift
wp_categories:
- meu-querido-diario
tags: [meu-querido-diario, programador]
worked: 3:30
---

Ontem a Apple lançou a linguagem [Swift](https://developer.apple.com/swift/) na WWDC 2014. Como nunca gostei da jurássica Objective-C (feia boba chata cara-de-melão), fiquei muito empolgado com a novidade. Finalmente uma linguagem moderna para se programar para Mac e iOS!

É uma linguagem com sintaxe moderna, limpa, prazerosa de programar, lembrando a sintaxe de linguagens interpretadas como Ruby, Python e JavaScript. Mas diferentemente dessas, a Swift é uma linguagem compilada e de tipagem <s>forte</s> [estática](http://fgsl.eti.br/blog/?p=118), que te força a sempre informar qual o tipo de conteúdo das variáveis, argumentos e retorno de funções: inteiro, string, array?

Essa obrigação de informar o tipo traz uma grande vantagem: seus erros serão detectados já pelo compilador, e não pelo usuário. Te força a fazer um código mais previsível e robusto, e o compilador ainda pode fazer otimizações para que o código rode mais rápido.

Já no lançamento a Apple disponibilizou gratuitamente um guia completo sobre a linguagem, em inglês, nos formatos [HTML](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/) e [iBook](https://itunes.apple.com/us/book/the-swift-programming-language/id881256329?mt=11).

Li a primeira metade do guia, que trata da sintaxe da linguagem, esses foram alguns dos pontos que me chamaram a atenção:

- A documentação fala muito sobre **código legível**. Eu levei anos para finalmente compreender a importância disso, e fico feliz que eles estejam dando a devida importância. Veja uma citação do livro: “Readability is always preferred over brevity”.

- Para melhorar a legibilidade dos **números** no código, é permitido colocar zeros à esquerda livremente (zero padding), inserir `_` para separar grupos de números e adicionar sinais de `+` na frente. Tudo isso não altera em nada o valor do número, serve apenas para melhorar sua leitura pelo programador.

    ```swift
    // normal
    let um_milhao = 1000000
    let seis_casas_decimais = 0.000001

    // mais legível
    let um_milhao = 1_000_000
    let seis_casas_decimais = 0.000_001
    ```

- **Intervalos numéricos** práticos `0..5` e `0...5`, igual em Ruby.

- Pode usar **caracteres Unicode em nomes de variáveis**. Inclusive na documentação eles mostram exemplos que usam Emojis (veja The Basics → Naming Constants and Variables). A única exceção são os caracteres de setas (como ← e →) que estão reservados. Imagino que poderão ser operadores no futuro, no lugar do feioso `->` que é hoje usado nas funções.

    ```swift
    let π = 3.14159
    let 🐶🐮 = "dogcow"  // Os Emojis podem não aparecer no seu navegador
    ```

- **Comentários multilinha** podem ser aninhados. Já tentou comentar um trecho grande de código que já possuía alguns comentários multilinha com `/* … */`? Pois é. Na Swift rola.

- **Interpolação de strings** (expandir variáveis e expressões dentro de strings) achei bem estranho ser `\(assim)`. Parênteses escapados? Fala sério! Se bem que não há um padrão estabelecido, cada linguagem faz diferente: `$shell`, `{$php}`, `#{ruby}`, `%(python)s`. Mas depois de ver bastante exemplos na documentação comecei a me acostumar. E se pensar que já tem `\t` e `\n` que significam “coisas especiais” no meio de uma string, usar `\(…)` é uma escolha que faz sentido.

    ```swift
    var nome_completo = "Fulano da Silva"
    var idade = 77
    println "Olá \(nome_completo), você tem \(idade) anos."
    ```

- Mesmo acostumando com o `\(…)` dentro das strings, tem que levar em conta que o parser dele é bem limitado: “The expressions you write inside parentheses within an interpolated string cannot contain an unescaped double quote (`"`) or backslash (`\`), and cannot contain a carriage return or line feed.”


- Há poucas funções/métodos nativos para lidar com **strings**. E o que eu mais gosto é lidar com strings. Que pena. Alguns deles: `hasPrefix`, `hasSuffix`, `uppercaseString`, `lowercaseString`, `countElements`, `isEmpty`.

- Pasmem: não tem [Expressões Regulares](/regex/) :(

- Há o conceito de **variáveis opcionais**. Somente elas podem ser definidas como `nil`, as variáveis normais não. Então uma variável normal não pode ser zerada. É mais um efeito colateral da tipagem forte, tem que acostumar.

- Tem o controverso [operador ternário](http://en.wikipedia.org/wiki/%3F:) `(condição ? sim : não)`. Não adianta, ele nunca vai morrer :)

- O comando `switch` tem o `break` implícito, ou seja, executa somente um `case` e não pula para o próximo. Aliás, assim deveriam ser todos os `switch` do mundo, para preservar a sanidade dos programadores. Mas se precisar pular para o próximo, basta usar o comando `fallthrough`.

- Achei interessante a ideia de dar nomes aos blocos de comandos `switch` e `while`. Assim, quando você está no meio de um loop, dentro de outro loop, dentro de outro loop, pode dar um `break nome`, para especificar exatamente de qual bloco você está saindo.

- A linha da declaração de uma função é um mundo à parte. Pode ser simples e concisa, mas também pode ser um caminhão de informações ao especificar, para cada argumento: nome externo, nome interno, tipo e valor default. E o tipo do argumento ainda pode ser um “function type” como por exemplo `(Int, Int) -> Int`. E no final da linha, ainda tem o operador `->` e o retorno da função, sendo que este retorno pode ser uma tupla com vários elementos, onde é preciso especificar o tipo e opcionalmente o nome de cada um.

    ```swift
    // Exemplo de declaração de função que recebe 3 argumentos
    // e retorna uma tupla com 3 elementos.
    //
    // Nomes externos dos argumentos: texto, iniciaEm, terminaEm
    // Nomes internos dos argumentos: txt, ini, fim
    // Tupla de retorno: (vogais, consoantes, outros)
    //
    func contaElementos(texto txt: String, iniciaEm ini: Int, terminaEm fim: Int)
        -> (vogais: Int, consoantes: Int, outros: Int) {

            // corpo da função
    }
    ```

No geral, gostei do que vi. É chato ter que especificar sempre os tipos de dados, e a falta de regex é um pecado, mas fora isso parece ser uma linguagem prazerosa de programar (algo que a Objective-C nunca foi). Pretendo brincar com ela.
