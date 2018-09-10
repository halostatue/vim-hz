scriptencoding utf-8

let g:startify_fortune_use_unicode = 1

augroup hzvim-startify
  autocmd!

  autocmd User Startified
        \ execute 'nnoremap <buffer> q :call g:NERDTree.Close()<CR>' . maparg('q', 'n')
augroup END
