scriptencoding utf-8

if hz#is#plugged('vim-smartinput') | finish | endif

if get(g:, 'smartinput_break_undo', 0) || v:version < 800
  let s:left = '<Left>'
  let s:right = '<Right>'
else
  let s:left = '<C-g>U<Left>'
  let s:right = '<C-g>U<Right>'
endif

call smartinput#define_rule({
      \   'at': '\%#',
      \   'char': '''',
      \   'input': ''''''.s:left,
      \   'filetype': ['rust'],
      \   'syntax': ['Special']
      \ })

call smartinput#map_to_trigger('i', '#', '#', '#')
call smartinput#define_rule({
      \   'at': '\%#',
      \   'char': '#',
      \   'input': '#{}'.s:left,
      \   'filetype': ['ruby'],
      \   'syntax': ['Constant', 'Special']
      \ })

call smartinput#map_to_trigger('i', '<Bar>', '<Bar>', '<Bar>')
call smartinput#define_rule({
      \   'at': '\({\|\<do\>\)\s*\%#',
      \   'char': '<Bar>',
      \   'input': '<Bar><Bar>'.s:left,
      \   'filetype': ['ruby']
      \ })
call smartinput#define_rule({
      \  'at': '\%#\_s*|',
      \  'char': '<Bar>',
      \  'input': '<C-r>=smartinput#_leave_block(''|'')<Enter>'.s:right,
      \  'filetype': ['ruby']
      \ })
call smartinput#define_rule({
      \  'at': '|\%#|',
      \  'char': '<BS>',
      \  'input': '<BS><Del>',
      \  'filetype': ['ruby']
      \ })
call smartinput#define_rule({
      \  'at': '||\%#',
      \  'char': '<BS>',
      \  'input': '<BS><BS>',
      \  'filetype': ['ruby']
      \ })
call smartinput#define_rule({
      \  'at': '\\\%#',
      \  'char': '<Bar>',
      \  'input': '<Bar>',
      \  'filetype': ['ruby']
      \ })
