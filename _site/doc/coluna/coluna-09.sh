vim \
  -c 'set background=dark' \
  -c 'TOhtml' \
  -c '%s@^<title>.*@<title>coluna do aurelio 09: vim (um vimrc diferente) | Aurelio.net</title>@' \
  -c 'w! coluna-09.html' \
  -c 'qa!' \
  coluna-09.vim
