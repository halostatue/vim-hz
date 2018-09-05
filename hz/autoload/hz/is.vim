scriptencoding utf-8

if exists('s:is') | finish | endif

let s:is =
      \ {
      \   'windows' : has('win16') || has('win32') || has('win64'),
      \   'cygwin' : has('win32unix'),
      \   'sudo' : $SUDO_USER !=# '' && $USER !=# $SUDO_USER
      \       && $HOME !=# expand('~' . $USER)
      \       && $HOME ==# expand('~' . $SUDO_USER),
      \ }

let s:is.mac = !s:is.windows && !s:is.cygwin
      \ && (has('mac') || has('macunix') || has('gui_macvim') ||
      \   (!executable('xdg-open') &&
      \     system('uname') =~? '^darwin'))

let s:is.macgui = s:is.mac && has('gui_running')

""
" Returns v:true if the platform is a Mac
function! hz#is#mac() abort
  return s:is.mac
endfunction

""
" Returns v:true if the platform is a Mac running the MacVim GUI
function! hz#is#macgui() abort
  return s:is.macgui
endfunction

""
" Returns v:true if the platform is Windows
function! hz#is#windows() abort
  return s:is.windows
endfunction

""
" Returns v:true if the platform is Cygwin
function! hz#is#cygwin() abort
  return s:is.cygwin
endfunction

""
" Returns v:true if the platform is running under `sudo`.
function! hz#is#sudo() abort
  return s:is.sudo
endfunction

""
" Returns v:true if vim is running under tmux
function! hz#is#tmux() abort
  return exists('$TMUX')
endfunction

""
" @usage {plug...}
" Returns v:true if any {plug...} has been added to the vim-plug configuration.
"
" This is used to provide conditional configuration options, such as disabling
" `netrw` if `NERDTree` is installed).
"
"     Plug 'scrooloose/nerdtree'
"
"     ...
"
"     if hz#is#plugged('nerdtree')
"       let g:loaded_netrwPlugin = 1
"       ...
"     endif
function! hz#is#plugged(plug, ...) abort
  let l:plugs = get(g:, 'plugs', [])
  if empty(l:plugs) | return v:false | endif
  return hz#fn#any(hz#fn#flatten(a:plug, a:000), { v -> has_key(l:plugs, v) })
endfunction

function! hz#is#all_plugged(plug, ...) abort
  let l:plugs = get(g:, 'plugs', [])
  if empty(l:plugs) | return v:false | endif
  return hz#fn#all(hz#fn#flatten(a:plug, a:000), { v -> has_key(l:plugs, v) })
endfunction
