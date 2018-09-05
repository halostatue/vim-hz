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

  if hz#is#plugged('andrews_nerdtree.vim')
    let g:andrews_nerdtree_all = 1

    if !exists('g:andrews_nerdtree_diff_key')
      let g:andrews_nerdtree_diff_key = 'D'
    endif

    if !exists('g:andrews_nerdtree_external_open_key')
      let g:andrews_nerdtree_external_open_key = 'gx'
    endif

    if !exists('g:andrews_nerdtree_interactive_edit_key')
      let g:andrews_nerdtree_interactive_edit_key = 'e'
    endif

    if !exists('g:andrews_nerdtree_startshell_mapping_key')
      let g:andrews_nerdtree_startshell_mapping_key = 'S'
    endif

    if !exists('g:andrews_nerdtree_quickfix_filter_auto')
      let g:andrews_nerdtree_quickfix_filter_auto = 0
    endif

    " Set up a global command that removes all filters
    if g:andrews_nerdtree_all ||
          \ g:andrews_nerdtree_git_filter ||
          \ g:andrews_nerdtree_quickfix_filter

      command! NERDTreeFilterOff call hz#plugins#_nerd_tree_filter_off()
    endif
  endif

  if hz#is#plugged('vim-line-jump')
    " default g:NERDTreeMapToggleFilters key map is 'f', change it to some key
    " else.
    let g:NERDTreeMapToggleFilters = 0

    "LineJump NERDTree key map
    augroup LineJumpNerdTree
      autocmd!
      autocmd BufEnter NERD_tree_\d\+ nnoremap <buffer> <nowait> <silent>
            \ f <ESC>:silent! call LineJumpSelectForward()<cr>
      autocmd BufEnter NERD_tree_\d\+ nnoremap <buffer> <nowait> <silent>
            \ ; <ESC>:silent! call LineJumpMoveForward()<cr>
      autocmd BufEnter NERD_tree_\d\+ nnoremap <buffer> <nowait> <silent>
            \ b <ESC>:silent! call LineJumpSelectBackward()<cr>
      autocmd BufEnter NERD_tree_\d\+ nnoremap <buffer> <nowait> <silent>
            \ , <ESC>:silent! call LineJumpMoveBackward()<cr>
      autocmd BufEnter NERD_tree_\d\+ nnoremap <buffer> <nowait> <silent>
            \ gh <ESC>:silent! call LineJumpMoveTop()<cr>
      autocmd BufEnter NERD_tree_\d\+ nnoremap <buffer> <nowait> <silent>
            \ gm <ESC>:silent! call LineJumpMoveMiddle()<cr>
      autocmd BufEnter NERD_tree_\d\+ nnoremap <buffer> <nowait> <silent>
            \ gl <ESC>:silent! call LineJumpMoveBottom()<cr>
    augroup END

    augroup LineJumpTagbar
      autocmd!
      autocmd BufEnter __Tagbar__ nnoremap <buffer> <nowait> <silent>
            \ f <ESC>:silent! call LineJumpSelectForward()<cr>
      autocmd BufEnter __Tagbar__ nnoremap <buffer> <nowait> <silent>
            \ ; <ESC>:silent! call LineJumpMoveForward()<cr>
      autocmd BufEnter __Tagbar__ nnoremap <buffer> <nowait> <silent>
            \ b <ESC>:silent! call LineJumpSelectBackward()<cr>
      autocmd BufEnter __Tagbar__ nnoremap <buffer> <nowait> <silent>
            \ , <ESC>:silent! call LineJumpMoveBackward()<cr>
      autocmd BufEnter __Tagbar__ nnoremap <buffer> <nowait> <silent>
            \ gh <ESC>:silent! call LineJumpMoveTop()<cr>
      autocmd BufEnter __Tagbar__ nnoremap <buffer> <nowait> <silent>
            \ gm <ESC>:silent! call LineJumpMoveMiddle()<cr>
      autocmd BufEnter __Tagbar__ nnoremap <buffer> <nowait> <silent>
            \ gl <ESC>:silent! call LineJumpMoveBottom()<cr>
    augroup END
  endif

  if hz#is#plugged('vim-cider-vinegar', 'vim-buffergator')
    let g:CiderEnableNERDTree = 1
    let g:CiderEnableBuffergator = 1
    let g:NERDTreeHijackNetrw = 1
    let g:NERDTreeQuitOnOpen = 1
    let g:buffergator_viewport_split_policy = 'N'
    let g:CiderToggleNERDTree = '[Space]-'
    let g:CiderToggleBuffergator = '[Space]='
    let g:CiderToggleQF = '<leader>q'
    let g:CiderToggleLL = '<leader>l'
  endif
endif
