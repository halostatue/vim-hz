scriptencoding utf-8

if hz#plugins#has('vim-git')
  augroup hzvim_autocmd_git_files
    autocmd!

    " These should not have buftypes set, so clear them.
    autocmd FileType gitcommit,gitconfig,gitrebase,gitsendemail
          \ setlocal buftype=

    autocmd FileType gitrebase nnoremap <buffer> <silent> S :Cycle<CR>
  augroup END
endif
