scriptencoding utf-8
""
" Hz.vim - vimrc
" vimrc for Austin Ziegler <halostatue@gmail.com>
"
" The options set in this file are known to work with MacVim 8.1. Other
" versions, platforms, or NeoVim, may need some changes or may be entirely
" incompatible. With this revision, I have explicitly dropped support for some
" versions of Vim entirely, by removing a number of backwards compatibility
" functions.

let g:hz_vim_vim_version = '2.0'
lockvar g:hz_vim_vim_version

" Skip initialization for a vim-tiny or vim-small environment.
if 0 | finish | endif

" Use vim settings. First because it changes other options as a side-effect.
if has('vim_starting') | set nocompatible | endif

" New to Vim 8, a defaults similar to Tim Pope's sensible. Use it before
" anything else.
unlet! g:skip_defaults_vim
source $VIMRUNTIME/defaults.vim

if isdirectory(expand('$HOME/.vim'))
  let g:hz_vim_root_path = expand('$HOME/.vim')
elseif isdirectory(expand('$HOME/vimfiles'))
  let g:hz_vim_root_path = expand('$HOME/vimfiles')
end
let &runtimepath = &runtimepath . printf(',%s/hz', g:hz_vim_root_path)

call hz#config#source([
      \ 'init',
      \ 'plugs',
      \ 'abbreviations',
      \ 'autocmd',
      \ 'commands',
      \ 'editing',
      \ 'filetype',
      \ 'keys',
      \ 'syntax',
      \ 'viewing',
      \ 'plug-ins/*',
      \ ])

call hz#config#platform()
call hz#config#ui()

call hz#config#source('local/*')
call hz#config#source('style')

set secure
