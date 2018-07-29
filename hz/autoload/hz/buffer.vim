scriptencoding utf-8

""
" Sets an update {callback} for a given {bufnr} every [interval], executing
" infinitely. Returns the timer number.
"
" @default interval=500 ms
function! hz#buffer#timer(bufnr, callback, ...)
  if !has('+timers') | throw "Timers are not enabled." | endif

  let l:timer = timer_start(a:0 ? a:1 : 500, a:callback, { 'repeat': -1 })

  augroup hz_buffer_callbacks
    execute printf("autocmd BufUnload <buffer=%d> call timer_stop('%s')", a:bufnr, l:timer)
  augroup END
endfunction
