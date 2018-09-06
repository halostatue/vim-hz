scriptencoding utf-8

if $TERM =~? '256color'
  set t_Co=256
endif

if &term =~? 'xterm'
  let &t_ti .= "\e[?2004h"
  let &t_te .= "\e[?2004l"
  let &pastetoggle = "\e[201~"

  noremap <special> <expr> <Esc>[200~ hz#ui#_xterm_paste_begin('0i')
  inoremap <special> <expr> <Esc>[200~ hz#ui#_xterm_paste_begin('')
  cnoremap <special> <Esc>[200~ <nop>
  cnoremap <special> <Esc>[201~ <nop>

  if get(g:, 'optimized_vertical_split')
    let &t_ti .= "\e[?6;69h"
    let &t_te .= "\e7\e[?6;69l\e8"
    let &t_CV = "\e[%i%p1%d;%p2%ds"
    let &t_CS = 'y'
  endif

  let &t_SI = "\e]12;lightgreen\x7"
  let &t_EI = "\e]12;white\x7"
endif

" Using the mouse on a terminal.
if has('mouse')
  set mouse=ar
  if has('mouse_sgr')
    set ttymouse=sgr
  else
    set ttymouse=xterm2
  endif

  " Paste.
  nnoremap <RightMouse> "+p
  xnoremap <RightMouse> "+p
  inoremap <RightMouse> <C-r><C-o>+
  cnoremap <RightMouse> <C-r>+
endif
