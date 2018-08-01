scriptencoding utf-8

if !hz#is#plugged('CtrlP', 'vim-ctrlspace') | finish | end

if hz#is#plugged('CtrlP')
  function! s:ctrlp_command(...)
    for l:cmd in a:000
      if executable(l:cmd)
        return l:cmd . ' %s -l --nocolor --hidden -g ""'
      endif
    endfor
    return ''
  endfunction

  let g:ctrlp_user_command = {
        \   'types': {
        \     1: [ '.git', 'cd %s && git ls-files . -co --exclude-standard' ],
        \     2: [ '.hg', 'hg --cwd %s status -numac -I . $(hg root)']
        \   },
        \   'fallback': s:ctrlp_command('pt', 'ag')
        \ }

  delfunction s:ctrlp_command

  let g:ctrlp_switch_buffer = 'Et'
  let g:ctrlp_extensions = [ 'funky', 'tag', 'dir', 'mixed', 'rtscript', 'undo' ]
  let g:ctrlp_working_path_mode = 'rwa'

  if len(g:ctrlp_user_command)
    " ag or pt are fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
  else
    let g:ctrlp_use_caching = 1
    let g:ctrlp_clear_cache_on_exit = 1
  endif

  let g:ctrlp_show_hidden = 1
  let g:ctrlp_open_new_file = 'v'
  let g:ctrlp_reuse_window = 'startify'
endif

if hz#is#plugged('vim-ctrlspace')
  function! s:ctrlspace_command(...)
    for l:cmd in a:000
      if executable(l:cmd)
        return l:cmd . ' -l --nocolor --hidden -g "" --ignore .git'
      endif
    endfor
    return ''
  endfunction

  let g:CtrlSpaceGlobCommand = s:ctrlspace_command('pt', 'ag')

  delfunction s:ctrlspace_command

  let g:CtrlSpaceCacheDir = expand($HOME . '/.cache')
endif
