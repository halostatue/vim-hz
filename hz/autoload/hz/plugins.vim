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
" function! hz#plugins#get_gemfile() abort
"     let l:gemfile = neomake#config#get('ruby.gemfile')
"     if l:gemfile isnot# g:neomake#config#undefined
"         return l:gemfile
"     endif
"
"     let l:project_root = neomake#utils#get_project_root()
"     if empty(l:project_root)
"         let l:gemfile = findfile('Gemfile', '.;~')
"     else
"         let l:gemfile = l:project_root . neomake#utils#Slash() . 'Gemfile'
"         if !filereadable(l:gemfile)
"             let l:gemfile = ''
"         endif
"     endif
"
"     call neomake#log#debug(
"                \ printf('ruby: setting b:neomake.ruby.gemfile=%s', string(l:gemfile)),
"                \ { 'bufnr': bufnr('%') })
"     call neomake#config#set('b:ruby.gemfile', l:gemfile)
"     return l:gemfile
" endfunction
"
" function! hz#plugins#neomakeInitJobWithBundler(...) abort dict
"     let l:gemfile = hz#plugins#get_gemfile() " s:get_gemfile()
"     if len(l:gemfile) > 0 && !empty(filter(readfile(l:gemfile),
"                \ { _i, line -> line =~# '\v\s*gem\s+[''"]' . escape(self.exe, '\') }))
"         let self.args = ['exec', self.exe] + self.args
"         let self.exe = 'bundle'
"     endif
" endfunction
"
" function! hz#plugins#_neomake_maybe_use_bundler(...) abort dict
"   let l:gemfile = findfile('Gemfile', '.;~')
"   if len(l:gemfile) > 0
"     if executable('bin/' . self.exe)
"       let self.exe = 'bin/' . self.exe
"     elseif hz#fn#any(readfile(l:gemfile), { l -> l =~# 'gem\s+[''"]' . self.exe })
"       let self.args = ['exec', self.exe] + self.args
"       let self.exe = 'bundle'
"     endif
"   endif
" endfunction
" vint: +ProhibitImplicitScopeVariable
