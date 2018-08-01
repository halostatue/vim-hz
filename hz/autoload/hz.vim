scriptencoding utf-8
""
" @section Introduction, introduction
" @stylized Hz.vim
" @library
" @order introduction config functions compatibility licence
"
" @plugin(stylized) is a collection of functions and commands that power
" Austin Ziegler's vim configuration.

""
" @section Compatibility
"
" All of the functions in @plugin are known to work with MacVim 8.1. Most of
" them will work on older Vim versions, other platforms, or NeoVim, but
" compatibility is not guaranteed.

""
" @section Licence
"
" @plugin(stylized) is public domain where possible, or licensed under CC0 1.0
" where not. There are no warranties, implied or expressed, about this @plugin
" or its suitability or fitness for any particular purpose.
"
" See https://creativecommons.org/publicdomain/zero/1.0/legalcode for more
" information.

""
" Returns a string representing the underlying platform as @plugin understands
" it. Will be one of `windows`, `cygwin`, `mac`, or `unix`.
function! hz#platform() abort
  if hz#is#windows()
    return 'windows'
  elseif hz#is#cygwin()
    return 'cygwin'
  elseif hz#is#mac()
    return 'mac'
  else
    return 'unix'
  endif
endfunction

""
" Report whether the function in {varname} provided exists, and if so,
" contains a valid function name. The function name may be a bare name (`fn`)
" or have parentheses at the end (`fn()`).
function! hz#valid_function(varname) abort
  return exists(a:varname) && exists('*' . substitute(eval(a:varname), '()$', ''))
endfunction

""
" Make {path}, prompting unless [force] is provided.
function! hz#mkpath(path, ...) abort
  if !isdirectory(a:path) && &l:buftype ==# '' &&
        \ ((a:0 && a:1) ||
        \  input(printf('"%s" does not exist; create? [y/N]', a:path)) =~? '^y')
    call mkdir(iconv(a:path, &encoding, &termencoding), 'p')
  endif
endfunction

""
" Portably produce a proper ISO 8601/RFC3339 timestamp. If [time] is not
" provided, the current time will be used.
function! hz#isotime(...) abort
  if a:0
    let l:zone = strftime('%z', a:1)
  else
    let l:zone = strftime('%z')
  endif

  let l:zone = substitute(l:zone, '\([-+]\)\(\d\{2}\)\(\d\{2}\)', '\1\2:\3', '')

  if a:0
    return printf('%s%s', strftime('%Y-%m-%dT%H:%M:%S', a:1), l:zone)
  else
    return printf('%s%s', strftime('%Y-%m-%dT%H:%M:%S'), l:zone)
  endif
endfunction

""
" @usage [dict] [default] Func [args]
"
" Try to call the given [Func] with an optional dictionary, default, and
" arguments.
"
"     hz#try('fugitive#statusline')
"     hz#try(function('fugitive#statusline'))
"
" If [Func] is a dictionary function (and not a partial function reference),
" it is necessary to provide the [dict] parameter to properly provide `self`.
"
"     hz#try({}, 'dict.Func')
"
" A [default] value may be provided before the function reference, if it is
" inside of a list.
"
"     hz#try(['default'], 'F')
"
" Arguments are passed after the function name or reference.
"
"     hz#try(['default'], 'F', 1, 2, 3)
"
" This function is originally by Tim Pope as part of Flagship.
"
" @default default=''
" @default dict={}
" @default args=[]
function! hz#try(...) abort
  let l:args = copy(a:000)
  let l:dict = {}
  let l:default = ''

  if type(get(l:args, 0)) == v:t_dict | let l:dict = remove(l:args, 0) | endif
  if type(get(l:args, 0)) == v:t_list | let l:default = remove(l:args, 0)[0] | endif
  if empty(l:args) | return l:default | endif

  let l:Func = remove(l:args, 0)
  if type(l:Func) == v:t_func || exists('*' . l:Func)
    return call(l:Func, l:args, l:dict)
  else
    return l:default
  endif
endfunction

""
" Answers if {needle} can be found in the provided {haystack} which may be a
" string, list, or dictionary (where is searches the values).
"
" If {haystack} is a string, but {needle} is not, returns false.
" If {haystack} is neither a string, list, nor dictionary, returns false.
function! hz#in(haystack, needle) abort
  if type(a:haystack) == v:t_string
    return type(a:needle) == v:t_string && strdix(a:haystack, a:needle) != -1
  elseif type(a:haystack) == v:t_list
    return index(a:haystack, a:needle) != -1
  elseif type(a:haystack) == v:t_dict
    return index(values(a:haystack), a:needle) != -1
  endif

  return v:false
endfunction

""
" Trims leading [pattern] from {string}.
"
" @default pattern='\_s' The regex for whitespace and newlines.
function! hz#trim_leading(string, ...) abort
  return substitute(a:string, printf('^%s\+', a:0 ? a:1 : '\_s'), '', '')
endfunction

""
" Trims trailing [pattern] from {string}.
"
" @default pattern='\_s' The regex for whitespace and newlines.
function! hz#trim_trailing(string, ...) abort
  let l:pattern = '\_s\+$'
  if a:0 == 1 | let l:pattern = a:1 . '\+$' | endif
  return substitute(a:s, printf('%s\+$', a:0 ? a:1 : '\_s'), '', '')
endfunction

""
" Trims both leading and trailing [pattern] from {string}.
"
" @default pattern='\_s' The regex for whitespace and newlines.
function! hz#trim(string, ...) abort
  let l:pattern = a:0 ? a:1 : '\_s'
  return hz#trim_trailing(hz#trim_leading(a:string, l:pattern), l:pattern)
endfunction

""
" Executes {command} while saving and restoring the window state.
function! hz#in_place(command) abort
  let l:saved_view = winsaveview()
  execute a:command
  call winrestview(l:saved_view)
endfunction

""
" Executes {command} while saving and restoring the most recent saved search
" history and the window state.
function! hz#with_saved_search(command) abort
  let l:ch = histnr('search')
  call hz#in_place(a:command)
  while l:ch != histnr('search') | call histdel('search', -1) | endwhile
  let @/ = histget('search', -1)
endfunction

""
" Clean trailing whitespace from the range.
function! hz#clean_whitespace() abort range
  call hz#with_saved_search(a:firstline . ',' a:lastline . 's/\s\+$//e')
endfunction

""
" Gets the value of {setting}, checking for a buffer override then a global
" value. That is, {setting} will be pulled from |b:|, then |g:|. A [default]
" value may be provided.
function! hz#get_setting(setting, ...) abort
  return get(b:, a:setting, get(g:, a:setting, get(a:000, 0, '')))
endfunction

""
" Execute the normal mode {motion} and return the text that it marks. For this
" to work, the {motion} must include a visual mode key (`V`, `v`, or `gv`).
"
" Both the 'z' register and the original cursor position will be restored
" after the text is yanked.
function! hz#get_motion(motion) abort
  let l:cursor = getpos('.')
  let l:reg = getreg('z')
  let l:type = getregtype('z')

  execute 'normal!' a:motion . '"zy'

  let l:text = @z

  call setreg('z', l:reg, l:type)
  call setpos('.', l:cursor)

  return l:text
endfunction

""
" Run the normal mode {command} from line {start} to {end}, opening any folds.
"
function! hz#mark_visual(command, start, end) abort
  if a:start != line('.') | execute a:start | endif

  silent! execute printf('%d,%dfoldopen', a:start, a:end)

  if a:end > a:start
    execute 'normal!' a:command . (a:end - a:start) . 'jg_'
  else
    execute 'normal!' a:command . 'g_'
  endif
endfunction

""
" Programmatically jump to the window identified by {bufname}.
function! hz#switch_window(bufname) abort
  let l:nr = bufwinnr(a:bufname)
  if l:nr >= 0 | execute l:nr . 'wincmd w' | endif
endfunction
