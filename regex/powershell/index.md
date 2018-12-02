---
title: Expressões Regulares + PowerShell
---

## Dicas

* O PowerShell usa o motor de regex do [.NET](/regex/dotnet/), o `System.Text.RegularExpressions`.
* Operadores principais: `-Match`, `-Replace`, `-Split`.
* O comando `switch` também aceita casamento com regex.
* Resultado do match fica no HashTable `$matches`.
* O padrão é ser case insensitive (assim como o Windows).
* Sempre use aspas simples para proteger a regex.
* Acentuação funciona 100%, no `\w` e inclusive em nomes de grupos!


## Links

* [about\_Regular\_Expressions](https://technet.microsoft.com/en-us/library/hh847880.aspx)
Documentação oficial (e resumida) sobre o suporte às regex no PowerShell.

* [about\_Comparison\_Operators](https://technet.microsoft.com/en-us/library/hh847759.aspx)
Documentação oficial sobre os operadores `-Match` e `-NotMatch`.

* [about_Split](https://technet.microsoft.com/en-us/library/hh847811.aspx)
Documentação oficial sobre o operador `-Split`.

* [Windows PowerShell Tip: Using the Switch Statement](https://technet.microsoft.com/en-us/library/ff730937.aspx)
Artigo sobre o comando `switch`, que explica como usar expressões regulares nele.

* [Regular Expression Language - Quick Reference](https://msdn.microsoft.com/en-us/library/az24scfc.aspx)
Lista completa de todos os metacaracteres disponíveis, as flags e as variáveis especiais da substituição. Leitura obrigatória pra quem quer dominar o assunto.
