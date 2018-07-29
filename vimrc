scriptencoding utf-8
""
" Hz.vim - vimrc
" vimrc for Austin Ziegler <halostatue@gmail.com>
"
" Last updated: 2018-07-27
"
" The options set in this file are known to work with MacVim 8.1. Other
" versions, platforms, or NeoVim, may need some changes or may be entirely
" incompatible.
"
" This has been cribbed from a number of sources over the years.
"
" There is no warranty on these scripts or promise that they will even work for
" you.

let g:hz_vim_vim_version = '2.0'
lockvar g:hz_vim_vim_version

" Skip initialization for a vim-tiny or vim-small environment.
if 0 | finish | endif

" Use vim settings. First because it changes other options as a side-effect.
if has('vim_starting') | set nocompatible | endif

let g:hz_vim_root_path = fnamemodify('<sfile>', ':p:h')
let &runtimepath = &runtimepath . printf(',%s/hz', g:hz_vim_root_path)

call hz#config#source('init')

call plug#begin(hz#cache#for('vim-plug'))
call hz#config#source('plugs')
call plug#end()

call hz#config#source([
        \ 'editing',
        \ 'viewing',
        \ 'autocmd-groups',
        \ 'filetype-defaults',
        \ 'plugin-settings',
        \ 'syntax-settings',
        \ 'commands',
        \ 'abbreviations',
        \ 'key-mappings',
        \ 'plugs/*',
        \ ])

call hz#config#platform()
call hz#config#ui()

set secure
