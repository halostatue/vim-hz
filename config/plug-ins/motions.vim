scriptencoding utf-8

if hz#is#plugged('vim-sneak')
  let g:sneak#s_next = 1
  " let g:sneak#label = 1
endif

if hz#is#plugged('vim-smartword')
  nmap w <Plug>(smartword-w)
  nmap b <Plug>(smartword-b)
  nmap e <Plug>(smartword-e)
  nmap ge <Plug>(smartword-ge)
endif
