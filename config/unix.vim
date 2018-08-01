scriptencoding utf-8

" Vim does not get along with fish, so reset to bash.
if &shell =~# 'fish'
  set shell=bash
endif
