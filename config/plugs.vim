scriptencoding utf-8

""
" @private
" If {cond} is true, then [opts] will be used as is, otherwise it will be
" modified to have empty 'on' and 'for' clauses.
"
" Use this as:
"
"     Plug 'plugin/repo', Cond(cond, { 'on': 'Command' })
"
" This function exists only during the sourcing of this file.
"
" @default opts={}
function! Cond(cond, ...)
  let l:opts = get(a:000, 0, {})
  return a:cond ? l:opts : extend(l:opts, { 'on': [], 'for': [] })
endfunction

Plug 'tpope/vim-sensible'

" {{{1 Generally useful utilities
Plug 'tpope/tpope-vim-abolish'
" }}}1

delfunction Cond
" vim:set foldmethod=marker
