scriptencoding utf-8

""
" Toggle between normal mode [jk] acting like g[jk] and not.
command! -nargs=0 -bar ToggleGJK call hz#toggle#gjk_mapping()

""
" Change the local directory to the buffer directory.
command! -nargs=0 -bar CDToBufferDir call hz#buffer#_cd_to_buffer_dir()

""
" Close the Quickfix window if it is open; open it if it is not.
command! -nargs=0 -bar ToggleQuickfixWindow call hz#ui#toggle_window('quickfix')

""
" Close the Location window if it is open; open it if it is not.
command! -nargs=0 -bar ToggleLocationWindow call hz#ui#toggle_window('location')

""
" Execute the arguments in the shell.
command! -complete=shellcmd -nargs=+ Shell call hz#ui#_execute_in_shell(<q-args>)

""
" Show the stack of syntax highlighting classes affecting whatever is under the
" cursor.
command! -nargs=0 -bar SynStack call hz#_synstack()

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
