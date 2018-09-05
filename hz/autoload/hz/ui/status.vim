scriptencoding utf-8

let s:config = {}

let s:config.modifiers =
      \ {
      \   'help': '[help]',
      \   'modified': '+',
      \   'unmodifiable' : '-',
      \   'readonly' : '🚫',
      \   'quickfix' : '',
      \   'preview' : '[preview]',
      \ }

function! hz#ui#status#_append_space(text) abort
  return a:text . (empty(a:text) ? '' : ' ')
endfunction

""
" Returns the buffer number as `[n/N]`. Suitable for use in setting a status
" line.
function! hz#ui#status#buffer() abort
  return printf('[%d/%d]', bufnr('%'), bufnr('$'))
endfunction

""
" Returns `[preview]` if the window is marked as a preview window.
function! hz#ui#status#preview() abort
  return &previewwindow ? s:config.modifiers.preview : ''
endfunction

""
" Returns status line file modifiers.
function! hz#ui#status#filemodifiers() abort
  if &buftype ==# 'help' | return s:config.modifiers.help | endif
  if &buftype ==# 'quickfix' | return s:config.modifiers.quickfix | endif

  let l:state = []
  if &modified | let l:state += [s:config.modifiers.modified] | endif
  if !&modifiable | let l:state += [s:config.modifiers.unmodifiable] | endif
  if &readonly | let l:state += [s:config.modifiers.readonly] | endif

  let l:state = empty(l:state) ? '' : printf('[%s]',  join(l:state, ''))
  let l:filetype = &filetype ==# '' ? '' : printf('[%s]', &filetype)

  return hz#ui#status#_append_space(join([l:state, l:filetype], ''))
endfunction

""
" Returns the SCM status (currently only supports fugitive).
function! hz#ui#status#scm() abort
  return hz#ui#status#_append_space(hz#try('fugitive#statusline'))
endfunction

""
" Returns the conflicted status.
function! hz#ui#status#conflicted() abort
  return hz#ui#status#_append_space(hz#try('ConflictedVersion'))
endfunction

""
" Returns search count information (currently only supports anzu).
function! hz#ui#status#search() abort
  return hz#ui#status#_append_space(hz#try('anzu#search_status'))
endfunction

""
" Returns CapsLockStatusline.
function! hz#ui#status#capslock() abort
  return hz#ui#status#_append_space(hz#try('CapsLockStatusline'))
endfunction

""
" Returns the current asynchronous run status.
function! hz#ui#status#asyncrun() abort
  let l:out = get(g:, 'asyncrun_status', '')
  return l:out . (l:out ? ' ' : '')
endfunction

function! hz#ui#status#_block(input, type, value) abort
  return substitute(a:input, '\m\C%' . a:type . '{\([^}]*\)}', a:value ? '\1' : '', 'g')
endfunction

" Block types:
" - e : error : ale.error
" - E : error, style : ale.style_error
" - w : warning : ale.warning
" - W : warning, style : ale.style_warning
" - o : or, non-style : ale.error || ale.warning
" - O : or, style : ale.style_error || ale.style_warning
" - b : and, non-style : ale.error && ale.warning
" - B : and, style : ale.style_error && ale.style_warning
" - a : all : ale.error && ale.style_error && ale.warning && ale.style_warning
" - A : either both : (ale.error || ale.style_error) && (ale.warning || ale.style_warning)
" - q : either error : ale.error || ale.style_error
" - Q : either warning : ale.warning || ale.style_warning
" - z : both error : ale.error && ale.style_error
" - Z : both warning : ale.warning && ale.style_warning
" - t : total / any : ale.total
let s:hs_status_syntax_ale =
      \ '[%q{Err }%e{%e}%z{+}%E{%E}%A{, }%Q{Warn }%w{%w}%Z{+}%W{%W}%t{ %l:%c}]'
lockvar s:hs_status_syntax_ale

""
" Returns a status line value for either syntastic or ale.
function! hz#ui#status#syntax() abort
  let l:out = ''

  if hz#is#plugged('syntastic')
    let l:out = hz#try('SyntasticStatuslineFlag')
  elseif hz#is#plugged('neomake')
    let l:out = hz#try('neomake#statuslineQflistStatus', 'qf:\ ')
  elseif hz#is#plugged('ale')
    let l:b = bufnr('')
    let l:ale = ale#statusline#Count(l:b)

    if l:ale.total > 0
      let l:out = get(g:, 'hz#ui#status#syntax#ale', s:hs_status_syntax_ale)

      let l:out = hz#ui#status#_block(l:out, 'e', l:ale.error)
      let l:out = hz#ui#status#_block(l:out, 'E', l:ale.style_error)
      let l:out = hz#ui#status#_block(l:out, 'w', l:ale.warning)
      let l:out = hz#ui#status#_block(l:out, 'W', l:ale.style_warning)
      let l:out = hz#ui#status#_block(l:out, 'o', l:ale.error || l:ale.warning)
      let l:out = hz#ui#status#_block(l:out, 'O', l:ale.style_error || l:ale.style_warning)
      let l:out = hz#ui#status#_block(l:out, 'b', l:ale.error && l:ale.warning)
      let l:out = hz#ui#status#_block(l:out, 'B', l:ale.style_error && l:ale.style_warning)
      let l:out = hz#ui#status#_block(l:out, 'a',
            \ (l:ale.error && l:ale.style_error) &&
            \ (l:ale.warning && l:ale.style_warning))
      let l:out = hz#ui#status#_block(l:out, 'A',
            \ (l:ale.error || l:ale.style_error) &&
            \ (l:ale.warning || l:ale.style_warning))
      let l:out = hz#ui#status#_block(l:out, 'q', l:ale.error || l:ale.style_error)
      let l:out = hz#ui#status#_block(l:out, 'Q', l:ale.warning || l:ale.style_warning)
      let l:out = hz#ui#status#_block(l:out, 'z', l:ale.error && l:ale.style_error)
      let l:out = hz#ui#status#_block(l:out, 'Z', l:ale.warning && l:ale.style_warning)
      let l:out = hz#ui#status#_block(l:out, 't', l:ale.total)

      " vint: -ProhibitUnusedVariable
      let l:flags = {
            \ '%': '%',
            \ 't': l:ale.total,
            \ 'e': l:ale.error,
            \ 'w': l:ale.warning,
            \ 'i': l:ale.info,
            \ 'E': l:ale.style_error,
            \ 'W': l:ale.style_warning,
            \ 'l': g:ale_buffer_info[l:b].loclist[0].lnum,
            \ 'c': g:ale_buffer_info[l:b].loclist[0].col }
      let l:out = substitute(l:out,
            \ '\v\C\%(-?\d*%(\.\d+)?)([tewiEWlc%])',
            \ '\=lib#wformat(submatch(1), l:flags[submatch(2)])',
            \ 'g')
      " vint: +ProhibitUnusedVariable
    endif
  endif

  return hz#ui#status#_append_space(l:out)
endfunction

function! hz#ui#status#_fzf() abort
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction
