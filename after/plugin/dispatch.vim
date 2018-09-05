scriptencoding utf-8

if has_key(g:, 'dispatch_handlers') && index(g:dispatch_handlers, 'jobs') == -1
  let s:position = index(g:dispatch_handlers, 'screen') + 1
  let g:dispatch_handlers = insert(g:dispatch_handlers, 'jobs', s:position)
  unlet s:position
endif
