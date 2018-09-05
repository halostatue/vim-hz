scriptencoding utf-8

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
