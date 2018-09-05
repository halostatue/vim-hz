scriptencoding utf-8

""
" Sets an update {callback} for a given {bufnr} every [interval], executing
" infinitely. Returns the timer number.
"
" @default interval=500 ms
function! hz#buffer#timer(bufnr, callback, ...) abort
  if !has('timers') | throw 'Timers are not enabled.' | endif

  let l:timer = timer_start(a:0 ? a:1 : 500, a:callback, { 'repeat': -1 })

  augroup hz_buffer_callbacks
    execute printf('autocmd BufUnload <buffer=%d> call timer_stop(''%s'')', a:bufnr, l:timer)
  augroup END
endfunction

function! hz#buffer#_cd_to_buffer_dir() abort
  let l:filetype = getbufvar(bufnr('%'), '&filetype')

  if l:filetype ==# 'vimfiler'
    let l:dir = getbufvar(bufnr('%'), 'vimfiler').current_dir
  elseif l:filetype ==# 'vimshell'
    let l:dir = getbufvar(bufnr('%'), 'vimshell').save_dir
  else
    let l:dir = isdirectory(bufname('%')) ?
          \ bufname('%') : fnamemodify(bufname('%'), ':p:h')
  endif

  execute 'lcd' fnameescape(l:dir)
endfunction
