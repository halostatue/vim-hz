scriptencoding utf-8

""
" Execute a command, capturing (appending) its output to a buffer. It works
" with hidden buffers as well as visible buffers.
"
" Copied from functions by Andrew Radev.
function! hz#bufferize#do(command) abort
  if a:command ==# ''
    return
  endif

  redir => l:output
  silent execute a:command
  redir END

  let l:bfz_buffer = hz#bufferize#bufnr(a:command)
  let l:current_buffer = bufnr('%')
  let l:at_last_line = v:false
  let l:name = 'Bufferize:\ ' . escape(a:command, ' ')

  if l:bfz_buffer != 0
    let l:saved_view = winsaveview()
    let l:at_last_line = (line('.') == line('$'))

    if l:bfz_buffer < 0
      execute 'sbuffer ' . abs(l:bfz_buffer)
    endif

    exec bufwinnr(abs(l:bfz_buffer)) . 'wincmd w'
    normal! gg0dG
  else
    new
    setlocal nowrap nonumber buftype=nofile
    let l:saved_view = winsaveview()
  endif

  execute 'file ' . l:name
  call setline(1, split(l:output, "\n"))
  set nomodified
  call winrestview(l:saved_view)

  if l:at_last_line
    normal! G
  endif

  if exists(':RunCommand') == 2
    execute 'RunCommand silent Bufferize ' . a:command
  endif

  if l:bfz_buffer < 0
    execute bufwinnr(abs(l:bfz_buffer)) . 'wincmd c'
  endif

  execute bufwinnr(l:current_buffer) . 'wincmd w'
endfunction

""
" Return the buffer number if the buffer has a window visible on this tabpage.
" Return a negative buffer number if the buffer is not visible.
function! hz#bufferize#bufnr(command) abort
  let l:name = 'Bufferize: ' . a:command
  for l:bufnr in tabpagebuflist()
    if bufname(l:bufnr) =~? l:name
      return l:bufnr
    endif
  endfor

  let l:bufnr = bufnr(l:name)

  if l:bufnr == -1
    return 0
  endif

  return -1 * l:bufnr
endfunction

function! hz#bufferize#_update_messages_buffer(...) abort
  silent call hz#bufferize#do('messages')
endfunction

""
" Bufferizes the `messages` command with an update callback. If messages are
" already bufferized, does nothing.
function! hz#bufferize#messages() abort
  if hz#bufferize#bufnr('messages')
    return
  endif

  call hz#bufferize#_update_messages_buffer()

  call hz#buffer#timer(hz#bufferize#bufnr('messages'),
        \ function('hz#bufferize_update_messages_buffer'), 500)
endfunction
