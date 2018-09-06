scriptencoding utf-8

function! hz#plugins#has(name) abort
  return exists('*hz#plugins#_' . a:name)
endfunction

function! hz#plugins#_nerd_tree_filter_off() abort
  if exists('g:andrews_nerdtree_quickfix_filter_on')
    unlet g:andrews_nerdtree_quickfix_filter_on
  endif

  if exists('g:andrews_nerdtree_git_filter_on')
    unlet g:andrews_nerdtree_git_filter_on
  endif

  call andrews_nerdtree#util#Render()
endfunction

function! hz#plugins#_init_quickrun_psqlpq() abort
  nmap <buffer> <Leader>r [qrpsqlpq]
  nnoremap <silent> <buffer> [qrpsqlpq]j :call qrpsqlpq#run('split')<CR>
  nnoremap <silent> <buffer> [qrpsqlpq]l :call qrpsqlpq#run('vsplit')<CR>
  nnoremap <silent> <buffer> [qrpsqlpq]r :call qrpsqlpq#run()<CR>
endfunction

" vint: -ProhibitImplicitScopeVariable
function! hz#plugins#_neomake_maybe_use_bundler(...) abort dict
  let l:gemfile = findfile('Gemfile', '.;~')
  if len(l:gemfile) > 0
    if executable('bin/' . self.exe)
      let self.exe = 'bin/' . self.exe
    elseif hz#fn#any(readfile(l:gemfile), { l -> l =~# 'gem\s+[''"]' . self.exe })
      let self.args = ['exec', self.exe] + self.args
      let self.exe = 'bundle'
    endif
  endif
endfunction
" vint: +ProhibitImplicitScopeVariable
