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
" Loop over the range of text and remove duplicate lines without changing the
" sort order. Originally by Damian Conway, presented in Scripting the Vim
" Editor, Part 4 at IBM developerWorks.
"
" https://www.ibm.com/developerworks/library/l-vim-script-4/index.html
"
" Add mappings:
"
"     nmap ;u :%call hz#range_uniq()<CR>
"
"     vmap u :call hz#range_uniq()<CR>
function! hz#range_uniq() range abort
  let l:seen = {}
  let l:uniq = [

  for l:line in getline(a:firstline, a:lastline)
    let l:normalized = '>' . l:line
    if !has_key(l:seen, l:normalized)
      call add(l:uniq, l:line)
      let l:seen[l:normalized] = 1
    endif
  endfor

  execute a:firstline . ',' . a:lastline . 'delete'
  call append(a:firstline - 1, l:uniq)
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
  let l:force = (a:0 && a:1)
  if !isdirectory(a:path) && &l:buftype ==# '' &&
        \ (l:force ||
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
" Flatten the {list...}. This version executes recursively, so be careful of the
" type of list that you try to flatten.
"
"     [1, 2, 3] == hz#flatten([1, 2, 3])
"
"     [1, 2, 3] == hz#flatten([1, [2, 3]])
"
"     [1, 2, 3] == hz#flatten([1, [2, [3]]])
function! hz#flatten(list) abort
  let l:list = []

  for l:item in a:list
    if type(l:item) == v:t_list
      call extend(l:list, hz#flatten(l:item))
    else
      call add(l:list, l:item)
    endif
  endfor

  return l:list
endfunction

function! hz#flatextend(...) abort
  let l:list = []

  for l:item in a:000
    if type(l:item) == v:t_list
      call extend(l:list, hz#flatten(l:item))
    else
      call add(l:list, l:item)
    endif
  endfor

  return l:list
endfunction

" function! hs#reset_on_filetype() abort
"   " Disable automatically insert comment.
"   setlocal formatoptions-=ro formatoptions+=mMBl
"
"   " Disable auto wrap.
"   if &l:textwidth != 70 && &filetype !=# 'help'
"     setlocal textwidth=0
"   endif
"
"   if &filetype !=# 'help'
"     call hs#smart_foldtext()
"   endif
"
"   if !&l:modifiable
"     setlocal nofoldenable
"     setlocal foldcolumn=0
"
"     if v:version >= 703
"       setlocal colorcolumn=
"     endif
"   endif
" endfunction
"
" function! hs#init_cmdwin() abort
"   nnoremap <buffer><silent> q :<C-u>quit<Return>
"   nnoremap <buffer><silent> <Tab> :<c-u>quit<Return>
"
"   call cursor(line('$'), 0)
"
"   startinsert!
" endfunction
