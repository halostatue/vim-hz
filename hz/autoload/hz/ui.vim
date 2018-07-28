scriptencoding utf-8

""
" Create a cleaner tabline.
"
"     let &tabline = '%!hz#ui#tabline()'
function! hz#ui#tabline(...) abort
  let l:s = []

  for l:i in range(1, tabpagenr('$'))
    let l:bufnrs = tabpagebuflist(l:i)
    let l:bufnr = l:bufnrs[tabpagewinnr(l:i) - 1]

    let l:no = l:i
    let l:mod = getbufvar(l:bufnr, '&modified') ? '!' : ''

    let l:title =
          \ !exists('*gettabvar') ?
          \      fnamemodify(bufname(l:bufnr), ':t') :
          \ gettabvar(l:i, 'title') !=# '' ?
          \      gettabvar(l:i, 'title') :
          \      fnamemodify((l:i == tabpagenr() ?
          \       getcwd() : gettabvar(l:i, 'cwd')), ':t')

    call extend(
          \ l:s,
          \ [
          \   '%[',
          \   l:i,
          \   ']%#',
          \   (l:i == tabpagenr() ? 'TabLineSel' : 'TabLine'),
          \   '#',
          \   l:title,
          \   l:mod,
          \   '%#TabLineFill#'
          \ ])
  endfor

  call add(l:s, '%#TabLineFill#%T%=#TabLine#')

  return join(l:s, '')
endfunction

""
" A cleaner foldtext function.
"
"     set foldtext='hz#ui#foldtext()'
function hz#ui#foldtext() abort
  let l:line = getline(v:foldstart)

  let l:nucolwidth = &foldcolumn + &number * &numberwidth
  let l:windowwidth = winwidth(0) - l:nucolwidth - 13
  let l:foldedlinecount = v:foldend - v:foldstart + 1

  let l:onetab = strpart('          ', 0, &tabstop)
  let l:line = substitute(l:line, '\t', l:onetab, 'g')

  let l:line = strpart(l:line, 0, l:windowwidth - 2 - len(l:foldedlinecount))
  let l:fillcharcount = l:windowwidth - len(l:line) - len(l:foldedlinecount) - 2
  return join([l:line, '… ', repeat(' ', l:fillcharcount), l:foldedlinecount, ' lines'], '')
endfunction

""
" The global default foldtext function for use with
" @function(hz#ui#smart_foldtext()).
let g:hz#ui#default_foldtext = 'hz#ui#foldtext'

""
" @setting b:hz#ui#default_foldtext
" A buffer-specific default foldtext function for use with
" @function(hz#ui#smart_foldtext()).

""
" @usage [foldtext]
" Sets the local 'foldtext' function to either a provided [foldtext]
" function.
"
" Without a [foldtext] function provided, a local 'foldtext' value of
" `getline(v:foldstart)` will be replaced with of
" @setting(b:hz#ui#default_foldtext), @setting(g:hz#ui#default_foldtext), or
" |foldtext()|.
function! hz#ui#smart_foldtext(...) abort
  if a:0 != 0
    let &l:foldtext = a:1
  else
    let l:ftf = &l:foldtext

    if l:ftf !~# 'getline(v:foldstart)' | return | endif

    if hs#valid_function('b:hz#ui#default_foldtext')
      let l:ftf = b:hz#ui#default_foldtext . '()'
    elseif hs#valid_function('g:hz#ui#default_foldtext')
      let l:ftf = g:hz#ui#default_foldtext . '()'
    else
      l:ftf = 'foldtext()'
    endif

    let &l:foldtext = l:ftf
  endif
endfunction
