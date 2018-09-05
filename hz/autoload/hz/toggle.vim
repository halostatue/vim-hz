scriptencoding utf-8

""
" @usage {option} [onoff]
" Toggle an {option} with `setlocal`. Accepts [onoff] to choose a specific
" state.
function! hz#toggle#option(option, ...) abort
  if a:0
    let l:option = (!!a:1 ? 'no' : '') . a:option
    execute 'setlocal' l:option
  else
    execute 'setlocal ' . a:option . '!'
  endif
  execute 'setlocal ' . a:option . '?'
endfunction

""
" @usage {variable} [onoff]
" Toggle an option flag {variable}. Accepts [onoff] to choose a specific state.
function! hz#toggle#variable(variable, ...) abort
  let l:val = eval(a:variable)

  if type(l:val) != v:t_number && type(l:val) != v:t_bool
    throw printf('Cannot toggle "%s" as it is not a number or boolean.',
          \ a:variable)
  endif

  let l:val = (a:0 ? !!a:1 : !l:val)

  execute printf('let %s = %d', a:variable, l:val)
  echo printf('%s = %s', a:variable, eval(a:variable))
endfunction

""
" @usage [onoff]
" Toggle the mapping of [jk] <--> g[jk]. Accepts [onoff] to chose a specific
" state (0 or v:false is off).
function! hz#toggle#gjk_mapping(...) abort
  if a:0
    let l:use = !!a:1
  else
    let l:use = get(b:, 'hzvim_gjk_mapping_state', 0)
  endif

  if l:use
    let b:hzvim_gjk_mapping_state = 0
    noremap <buffer> j j
    noremap <buffer> k k
    noremap <buffer> gj gj
    noremap <buffer> gk gk

    xnoremap <buffer> j j
    xnoremap <buffer> k k
    xnoremap <buffer> gj gj
    xnoremap <buffer> gk gk
  else
    let b:hzvim_gjk_mapping_state = 1
    noremap <buffer> j gj
    noremap <buffer> k gk
    noremap <buffer> gj j
    noremap <buffer> gk k

    xnoremap <buffer> j gj
    xnoremap <buffer> k gk
    xnoremap <buffer> gj j
    xnoremap <buffer> gk k
  endif
endfunction
