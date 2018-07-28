" Halostatue vimrc library: config functions
"
" Last updated: 2018-07-27
scriptencoding utf-8

if exists('s:loaded') | finish | endif

let s:loaded = {}

function! s:loaded(from, ...)
  let l:found = v:false
  for l:pattern in hz#flatten(a:000)
    for l:vim in globpath(a:from, l:pattern, 0, 1)
      if !get(s:loaded, l:vim)
        execute 'source' fnameescape(l:vim)
        let l:found = v:true
        let s:loaded[l:vim] = v:true
        let s:loaded[l:pattern] = v:true
      endif
    endfor
  endfor
  return l:found
endfunction

""
" @usage [name]
" If [name] is provided, reports whether a file or pattern matching [name] has
" been loaded.
"
" If not provided, returns a dict of all configuration files loaded through
" hz#config functions, as well as the patterns that loaded them in the first
" place.
function! hz#config#loaded(...) abort
  if !exists('s:loaded') | let s:loaded = {} | endif

  if a:0 != 0
    return get(s:loaded, a:1,
          \    get(s:loaded, hz#config#name(a:1),
          \        get(s:loaded, fnamemodify(hz#config#name(a:1), ':~:.'))))
  else
    return s:loaded
  endif
endfunction

""
" Normalizes the pattern provided to a config pattern.
"
" * hz#config#name('init') -> 'config/init.vim'
" * hz#config#name('config/init') -> 'config/init.vim'
" * hz#config#name('plug/*') -> 'config/plug/*.vim'
" * hz#config#name('/etc/init.vim') -> '/etc/init.vim'
function! hz#config#name(pattern) abort
  if a:pattern !~# '^/' && a:pattern !~# '^config/'
    let l:pattern = 'config/' . a:pattern
  else
    let l:pattern = a:pattern
  endif

  if fnamemodify(l:pattern, ':e') ==# '' | let l:pattern = l:pattern . '.vim' | endif

  return l:pattern
endfunction

""
" @usage [from] {pattern}
" Returns v:true if {pattern} can be found in [from], which is 'runtimepath'
" by default.
"
" @default from='runtimepath'
function! hz#config#exists(pattern, ...) abort
  if a:0 == 1
    let l:from = a:pattern
    let l:pattern = a:1
  else
    let l:from = &runtimepath
    let l:pattern = a:pattern
  endif

  return !empty(globpath(l:from, l:pattern, 0, 1))
endfunction

""
" Source the file or files expressed by {pattern...} from 'runtimepath'. This is
" similar to the the |:source| command.
"
" Multiple patterns may be provided either as multiple arguments or one or
" more lists of patterns.
function! hz#config#runtime(pattern, ...) abort
  return s:loaded(&runtimepath, hz#flatextend(a:pattern, a:000))
endfunction

""
" Source the file or files expressed by {pattern...} as config names (see
" @function(hz#config#name) from 'runtimepath'.
"
" Multiple patterns may be provided either as multiple arguments or one or
" more lists of patterns.
"
" If one or more files has been loaded, one or more keys will be set to
" `v:true`. The following two examples mean the same thing:
"
"     hz#config#source('editing', 'viewing')
"
"     hz#config#source(['editing', 'viewing'])
function! hz#config#source(pattern, ...) abort
  let l:found = v:false

  for l:pattern in hz#flatextend(a:pattern, a:000)
    let l:config = hz#config#name(l:pattern)
    if hz#config#runtime(l:config)
      let s:loaded[l:config] = v:true
      let s:loaded[l:pattern] = v:true
      let l:found = v:true
    endif
  endfor

  return l:found
endfunction

""
" Sources config files that match the platform has returned from
" @function(hz#platform).
function! hz#config#platform() abort
  return hz#config#source(hz#platform())
endfunction

""
" If the GUI is running (`has('gui_running')`), sources a `gui` config file.
" If not, it sources a `terminal` config file.
function! hz#config#ui() abort
  if has('gui_running')
    return hz#config#source('gui')
  else
    return hz#config#source('terminal')
  endif
endfunction
