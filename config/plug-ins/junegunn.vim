scriptencoding utf-8

" Configurations for various junegunn plugins.
if !0 | finish | endif

if hz#is#plugged('vim-slash')
  if has('timers')
    noremap <expr> <plug>(slash-after) 'zz'.slash#blink(2, 50)
  else
    noremap <plug>(slash-after) zz
  endif
endif

if hz#is#plugged('vim-github-dashboard')
  if !has_key(g:, 'github_dashboard') | let g:github_dashboard = {} | endif
endif

if hz#is#plugged('vim-after-object')
  augroup junegunn-vim-after-object
    autocmd!

    autocmd VimEnter * call after_object#enable([']', '['], '=', ':', '-', '#', ' ')
  augroup END
endif

if hz#is#plugged('fzf.vim')
  let g:fzf_history_dir = '~/.local/share/fzf-history'
  let g:fzf_buffers_jump = 1

  command! -bang -nargs=* Ag
        \ call fzf#vim#ag(<q-args>,
        \                 <bang>0 ? fzf#vim#with_preview('up:60%')
        \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
        \                 <bang>0)

  command! -bang -nargs=* Rg
        \ call fzf#vim#grep(
        \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
        \   <bang>0 ? fzf#vim#with_preview('up:60%')
        \           : fzf#vim#with_preview('right:50%:hidden', '?'),
        \   <bang>0)
  command! -bang -nargs=? -complete=dir Files
        \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

  augroup hsconfig-fzf
    autocmd!

    autocmd  FileType fzf set laststatus=0 noshowmode noruler
          \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

    autocmd! User FzfStatusLine call hz#ui#status#_fzf()
  augroup END

  let g:rg_command = '
        \ rg --column --line-number --no-heading --fixed-strings --ignore-case
        \ --no-ignore --hidden --follow --color "always"
        \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
        \ -g "!{.git,node_modules,vendor}/*" '

  command! -bang -nargs=* F
        \ call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)
endif
