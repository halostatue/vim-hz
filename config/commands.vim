scriptencoding utf-8

""
" Toggle between normal mode [jk] acting like g[jk] and not.
command! -nargs=0 -bar ToggleGJK call hz#toggle#gjk_mapping()

""
" Change the local directory to the buffer directory.
command! -nargs=0 -bar CDToBufferDir call <SID>cd_to_buffer_dir()

""
" Close the Quickfix window if it is open; open it if it is not.
command! -nargs=0 -bar ToggleQuickfixWindow call <SID>toggle_window('quickfix')

""
" Close the Location window if it is open; open it if it is not.
command! -nargs=0 -bar ToggleLocationWindow call <SID>toggle_window('location')

""
" Execute the arguments in the shell.
command! -complete=shellcmd -nargs=+ Shell call <SID>execute_in_shell(<q-args>)

""
" Show the stack of syntax highlighting classes affecting whatever is under the
" cursor.
command! -nargs=0 -bar SynStack call <SID>synstack()

""
" Undo diff mode.
command! -nargs=0 Nodiff setlocal nodiff noscrollbind wrap

""
" Set or reset the foldtext function.
command! -nargs=? -complete=function SmartFoldText call hz#ui#smart_foldtext(<args>)

""
" Clean trailing whitespace.
command! CleanWhitespace call hz#clean_whitespace()

""
" Clean ANSI color escapes from the range.
command! CleanAnsiColors call hz#with_saved_search("s/\\e\\[.\\{-}m//ge")

""
" Clean trailing <CR> characters from the range.
command! CleanTrailingCR call hz#with_saved_search("s/\\r$//e")

""
" Clean multiple newlines.
command! CleanDoubleLines call hz#with_saved_search("s/^\\n\\+/\\r/e")

""
" Bufferize a command
command! -nargs=+ -complete=command Bufferize call hz#bufferize#do(<q-args>)

""
" Bufferize messages
command! -nargs=0 Messages call hz#bufferize#messages()

function! s:cd_to_buffer_dir()
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

let s:toggle_window_commands =
      \ {
      \   'quickfix': { 'close': 'cclose', 'open': 'copen' },
      \   'location': { 'close': 'lclose', 'open': 'lopen' }
      \ }
lockvar s:toggle_window_commands

function! s:toggle_window(type)
  let l:w = winnr('$')
  execute s:toggle_window_commands[a:type].close
  if l:w == winnr('$')
    execute s:toggle_window_commands[a:type].open
    setlocal nowrap whichwrap=b,s
  endif
endfunction

function! s:execute_in_shell(command)
  let l:cmd = join(map(split(a:command), 'expand(v:val)'))
  let l:winnr = bufwinnr(printf('^%s$', l:cmd))

  if l:winnr < 0
    silent! execute printf('botright vnew %s', fnameescape(l:cmd))
  else
    silent! execute printf('%dwincmd w', l:winnr)
  endif

  setlocal buftype=nowrite bufhidden=wipe
        \ nobuflisted noswapfile nowrap nonumber

  silent! execute 'silent %!'. l:cmd
  silent! redraw
  silent! execute
        \ 'autocmd BufUnload <buffer> bufwinnr(' . bufnr('#') .
        \ ') . ''wincmd w'''
  silent! execute
        \ 'nnoremap <silent> <buffer> <LocalLeader>r ' .
        \ ':call <SID>execute_in_shell(' . l:cmd ')<CR>' .
        \ exists(':CleanAnsiColors') ? ':CleanAnsiColors<CR>' : ''
  silent! execute 'nnoremap <silent> <buffer> q :quit<CR>'
  if exists(':CleanAnsiColors') | silent! execute CleanAnsiColors | endif
endfunction

function! s:synstack()
  echo join(map(
        \ synstack(line('.'), col('.')), 'synIDattr(v:val, ''name'')'),
        \ ' > ')
endfunction
