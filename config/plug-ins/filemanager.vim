scriptencoding

if !hz#is#plugged('vim-dirvish', 'vim-vinegar', 'nerdtree') | finish | endif

if hz#is#plugged('vim-dirvish')
  nmap <silent> [Space]- <Plug>(dirvish_up)
  nmap <silent> [Space]h- <Plug>(dirvish_split_up)
  nmap <silent> [Space]v- <Plug>(dirvish_vsplit_up)
elseif hz#is#plugged('vim-vinegar')
  nmap <silent> [Space]- <Plug>VinegarUp
  nmap <silent> [Space]t- <Plug>VinegarTabUp
  nmap <silent> [Space]h- <Plug>VinegarSplitUp
  nmap <silent> [Space]v- <Plug>VinegarVerticalSplitUp
endif

if hz#is#plugged('nerdtree')
  let g:NERDTreeShowBookmarks = 1
  let g:NERDTreeChDirMode = 2
  let g:NERDTreeQuitOnOpen = 1
  let g:NERDTreeMouseMode = 2
  let g:NERDTreeShowHidden = 1
  let g:NERDTreeIgnore = [ '\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg',
        \ '\.svn', '\.bzr' ]

  if hz#is#plugged('vim-emoji')
    let g:NERDTreeIndicatorMapCustom = {
          \ 'Modified'  : emoji#for('eight_spoked_asterisk'),
          \ 'Staged'    : emoji#for('white_check_mark'),
          \ 'Untracked' : emoji#for('question'),
          \ 'Renamed'   : emoji#for('arrow_right'),
          \ 'Unmerged'  : emoji#for('interrobang'),
          \ 'Deleted'   : emoji#for('x'),
          \ 'Dirty'     : '✗',
          \ 'Clean'     : '✔︎',
          \ 'Ignored'   : emoji#for('no_entry_sign'),
          \ 'Unknown'   : emoji#for('grey_question')
          \ }
  endif

  nnoremap <silent> <F4> :NERDTreeToggle<Return>
endif
