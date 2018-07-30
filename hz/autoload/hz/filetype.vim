scriptencoding utf-8

""
" Reset some commonly changed defaults by filetype/syntax plug-ins to better
" match my preferences. If a function hz#filetype#&filetype exists, call it
" (allowing further overrides to be provided as functions in this file).
function! hz#filetype#reset() abort
  " Disable automatic insert of comment on open ('o'/'O'), but leave it on
  " '<Enter>'. Also fix insert long-line handling and multi-byte character
  " handling.
  setlocal formatoptions-=o formatoptions+=mMBl

  " Disable autowrap.
  if &l:textwidth != 70 && &filetype !=# 'help'
    setlocal textwidth=0
  endif

  " Potentially fix the foldtext function if it was set badly.
  if &filetype !=# 'help' | call hz#ui#smart_foldtext() | endif

  " Turn off folds and colour columns if the buffer is not modifiable.
  if !&l:modifiable
    setlocal nofoldenable foldcolumn=0 colorcolumn=
  endif

  if exists('*hz#filetype#' . &filetype)
    execute printf('call hz#filetype#%s()', &filetype)
  endif
endfunction
