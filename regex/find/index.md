---
title: Expressões Regulares + find
---

## Referência rápida dos metacaracteres

```
Comando         Metacaracteres (BSD/Mac)
find            .  ^  $  *           [ ] \{\} \(\)  \1
find -E         .  ^  $  *  +  ?  |  [ ]  { }  ( )  \1

 -regextype     Metacaracteres (GNU/Linux)
emacs           .  ^  $  *  +  ?  |  [ ]      \(\)  \1
posix-basic     .  ^  $  * \+ \? \|  [ ] \{\} \(\)  \1
posix-extended  .  ^  $  *  +  ?  |  [ ]  { }  ( )  \1
posix-awk       .  ^  $  *  +  ?  |  [ ]  { }  ( )  \1
posix-egrep     .  ^  $  *  +  ?  |  [ ]  { }  ( )  \1
```

## Links

* [man find — Linux](http://linux.die.net/man/1/find)
* [man find — FreeBSD](http://www.unix.com/man-page/FreeBSD/1/find/)
* [man 7 regex — Linux](http://linux.die.net/man/7/regex)
* [man 7 re_format — FreeBSD](http://www.unix.com/man-page/FreeBSD/7/re_format/)
* [GNU find — Manual completo](http://www.gnu.org/software/findutils/manual/html_mono/find.html)
