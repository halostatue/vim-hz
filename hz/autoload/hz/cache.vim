" Halostatue vimrc library: cache management
"
" Last updated: 2018-07-27
scriptencoding utf-8

if exists('s:vim_cache') | finish | endif

if exists('$VIM_CACHE')
  let s:vim_cache = expand('$VIM_CACHE')
elseif exists('$CACHE')
  let s:vim_cache = expand('$CACHE')
elseif hz#is#windows() || hz#is#cygwin()
  let s:vim_cache = expand('~/vimcache')
else
  let s:vim_cache = expand('~/.cache')
endif

function! s:mkcachepath(...)
  let l:path = join(hz#fn#flatten(s:vim_cache, a:000), '/')
  if !isdirectory(l:path) | call mkdir(l:path, 'p') | endif
  return l:path
endfunction

call s:mkcachepath()

""
" Return the cache root path.
function! hz#cache#root() abort
  return s:vim_cache
endfunction

""
" Create and return a named cache for the given {path...}.
function! hz#cache#for(path, ...) abort
  return s:mkcachepath([a:path, a:000])
endfunction
