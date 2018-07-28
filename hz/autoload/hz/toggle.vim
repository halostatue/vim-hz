scriptencoding utf-8

""
" Toggle an {option} with `setlocal`.
function! hz#toggle#option(option) abort
  execute 'setlocal ' . a:option . '!'
  execute 'setlocal ' . a:option . '?'
endfunction

""
" Toggle an option flag {variable}.
function! hz#toggle#variable(variable) abort
  let l:val = eval(a:variable)

  if type(l:val) != v:t_number && type(l:val) != v:t_bool
    throw printf('Cannot toggle "%s" as it is not a number or boolean.', a:variable)
  endif

  execute printf('let %s = !%s', a:variable, a:variable')
  echo printf('%s = %s', a:variable, eval(a:variable))
endfunction
