scriptencoding utf-8

if hz#is#plugged('editorconfig-vim')
  let g:EditorConfig_exclude_patterns = [ 'fugitive://.*' ]
endif

if hz#is#plugged('vim-unified-diff')
  set diffexpr=unified_diff#diffexpr()
endif

if hz#is#plugged('vim-swap')
  omap i, <Plug>(swap-textobject-i)
  xmap i, <Plug>(swap-textobject-i)
  omap a, <Plug>(swap-textobject-a)
  xmap a, <Plug>(swap-textobject-a)
endif

if hz#is#plugged('indentLine')
  augroup hz-plug-ins-editing-indentLine
    autocmd! User indentLine doautocmd indentLine Syntax
  augroup END
endif
