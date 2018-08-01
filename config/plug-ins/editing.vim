scriptencoding utf-8

if hz#is#plugged('editorconfig-vim')
  let g:EditorConfig_exclude_patterns = [ 'fugitive://.*' ]
endif

if hz#is#plugged('vim-unified-diff')
  set diffexpr=unified_diff#diffexpr()
endif
