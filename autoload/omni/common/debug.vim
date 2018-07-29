scriptencoding utf-8

let s:trace = []

""
" Start debugging omnicompletion functions. Originally by Vissale NEANG.
function! omni#common#debug#start() abort
  let s:trace = [ '============ Debug Start ============' ]
  call writefile(s:trace, 'omni.dbg')
endfunction

""
" Stop debugging omnicompletion functions. Originally by Vissale NEANG.
function! omni#common#debug#end() abort
  call extend(s:trace, [ '============= Debug End =============', '' ])
  call writefile(s:trace, 'omni.dbg')
endfunc

""
" Add a line to the omnicompletion debug trace. If just given {name}, the
" trace line is just the {name}. If given {name} and [params...], the trace
" line is `{name}: (param1) (param2) ... (paramN)`.
function! omni#common#debug#trace(name, ...) abort
  let l:trace = a:name . (a:0 ? ':' : '')
  for l:param in a:000
    let l:trace = printf('%s (%s)', l:trace, string(l:param))
  endfor

  call add(s:trace, l:trace)
endfunc
