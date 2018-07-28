scriptencoding utf-8

let s:config = {}

let s:config.modifiers =
      \ {
      \   'help': '[help]',
      \   'modified': '+',
      \   'unmodifiable' : '-',
      \   'readonly' : '🚫',
      \   'quickfix' : '',
      \ }

""
" Returns the buffer as `[n/N]`. Suitable for use in setting a status line.
function! hz#ui#status#buffer() abort
  return printf('[%d/%d]', bufnr('%'), bufnr('$'))
endfunction

""
" Returns `[preview]` if the window is marked as a preview window.
function! hz#ui#status#preview() abort
  return &previewwindow ? '[preview]' : ''
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

  let l:state = ''
  if !empty(l:state) | let l:state = '[' . join(l:state, '') . ']' | endif

  let l:filetype = ''
  if &filetype !=# '' | let l:filetype = '[' . &filetype . ']' | endif

  let l:result = join([l:state, l:filetype], '')

  if !empty(l:result) | let l:result .= ' ' | endif

  return l:result
endfunction

""
" Returns the status information from fugitive.
function! hz#ui#status#fugitive() abort
  let l:result = hz#try('fugitive#statusline')
  if !empty(l:result) | let l:result .= ' ' | end
  return l:result
endfunction

""
" Returns the current asynchronous run status.
function! hz#ui#status#asyncrun() abort
  return get(g:, 'asyncrun_status', '')
endfunction

function! s:block(input, type, value)
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
  if hz#is#plugged('syntastic')
    return hz#try('SyntasticStatuslineFlag')
  elseif hz#is#plugged('ale')
    let l:b = bufnr('')
    let l:ale = ale#statusline#Count(l:b)

    if l:ale.total > 0
      let l:out = get(g:, 'hz#ui#status#syntax#ale', s:hs_status_syntax_ale)

      let l:out = s:block(l:out, 'e', l:ale.error)
      let l:out = s:block(l:out, 'E', l:ale.style_error)
      let l:out = s:block(l:out, 'w', l:ale.warning)
      let l:out = s:block(l:out, 'W', l:ale.style_warning)
      let l:out = s:block(l:out, 'o', l:ale.error || l:ale.warning)
      let l:out = s:block(l:out, 'O', l:ale.style_error || l:ale.style_warning)
      let l:out = s:block(l:out, 'b', l:ale.error && l:ale.warning)
      let l:out = s:block(l:out, 'B', l:ale.style_error && l:ale.style_warning)
      let l:out = s:block(l:out, 'a',
            \ (l:ale.error && l:ale.style_error) &&
            \ (l:ale.warning && l:ale.style_warning))
      let l:out = s:block(l:out, 'A',
            \ (l:ale.error || l:ale.style_error) &&
            \ (l:ale.warning || l:ale.style_warning))
      let l:out = s:block(l:out, 'q', l:ale.error || l:ale.style_error)
      let l:out = s:block(l:out, 'Q', l:ale.warning || l:ale.style_warning)
      let l:out = s:block(l:out, 'z', l:ale.error && l:ale.style_error)
      let l:out = s:block(l:out, 'Z', l:ale.warning && l:ale.style_warning)
      let l:out = s:block(l:out, 't', l:ale.total)

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
            \ '\=lib#wformat(submatch(1), flags[submatch(2)])',
            \ 'g')
      return l:out
    endif
  endif

  return ''
endfunction
