" This script contains 'global'/all-buffer-type auto commands.

if !has('autocmd') | finish | endif

scriptencoding utf-8

augroup hzvim_autocmd_all_buffers
  autocmd!

  " Check for updates on window entry
  autocmd WinEnter * checktime

  " Reset paste mode after leaving insert.
  autocmd InsertLeave *
        \  if &paste
        \|   set nopaste mouse=ar
        \|   echo 'nopaste'
        \| endif

  " Update the diff, if showing a diff, after leaving insert.
  autocmd InsertLeave *
        \ if &l:diff | diffupdate | endif

  " Try to create the directory for the current file if it doesn't exist
  " before writing.
  autocmd BufWritePre * call hz#mkpath(expand('<afile>:p:h'), v:cmdbang)

  " On a filetype or syntax event, call hz#filetype() to reset some features
  " that are commonly broken by filetype plug-ins.
  autocmd FileType,Syntax * call hz#filetype#reset()

  " Update the filetype after writing.
  autocmd BufWritePost *
        \  if &filetype ==# '' || exists('b:ftdetect')
        \|   unlet! b:ftdetect
        \|   filetype detect
        \| endif

  " When editing a file, always jump to the last known cursor position, if
  " it's invalid, or when in an event handler (when dropping a file on gvim).
  autocmd BufReadPost *
        \  if line('''"') > 1 && line('''"') <= line("$")
        \|   exe 'keepjumps normal g`"'
        \| endif

  " Consider resetting the foldtext after buffer read.
  autocmd BufReadPost * call hz#ui#smart_foldtext()

  " Read modelines from files and turn on line numbers.
  autocmd BufRead * set modeline number

  " Resize window splits when the window is resized.
  autocmd VimResized * wincmd =
augroup END

" Set q/<Tab> to quit the command window, move the first character, and start
" in insert mode.
function! s:cmdwin_init()
  nnoremap <buffer><silent> q :<C-u>quit<Return>
  nnoremap <buffer><silent> <Tab> :<c-u>quit<Return>

  call cursor(line('$'), 0)

  startinsert!
endfunction

augroup hzvim_autocmd_cmdwin
  autocmd!
  autocmd CmdwinEnter * call s:cmdwin_init()
augroup END

augroup hzvim_autocmd_silence_gui_beep
  autocmd!
  autocmd GUIEnter * set noerrorbells visualbell t_vb=
augroup END

function! s:startup()
  if exists('s:std_in')
    unlet s:std_in
    return
  endif

  if exists(':Startify')
    Startify
  endif

  if exists(':NERDTree')
    if argc() == 1 && isdirectory(argv()[0])
      execute 'NERDtree' argv()[0]
    else
      execute NERDTree
    endif
    wincmd w
  endif
endfunction

" If Startify and NERDTree exist, start them.
augroup hzvim_autocmd_startup
  autocmd!
  autocmd StdinReadPre * let s:stdin = 1
  autocmd VimEnter * call s:startup()
augroup END
