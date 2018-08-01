scriptencoding utf-8

if !hz#is#plugged('ale', 'syntastic') | finish | endif

if hz#is#plugged('ale')
  let g:airline#extensions#ale#enabled = hs#plug#in('airline')

  let g:ale_open_list = 1
  let g:ale_set_quickfix = 1
  let g:ale_sign_column_always = 1

  let g:ale_linters = {
        \   'ruby': [ 'brakeman', 'rubocop', 'ruby' ]
        \ }

  let g:ale_ruby_rubocop_executable = 'bundle'

  let g:ale_rust_cargo_use_check = 1

  " function! s:configure_ale_ruby()
  "   let l:gemfile = findfile('Gemfile', '.;~')
  "   if len(l:gemfile) > 0
  "     let b:ale_ruby_rubocop_executable = 'bundle'
  "   endif
  " endfunction
  "
  " augroup hsautocmd-ale-ruby
  "   autocmd!
  "
  "   autocmd FileType ruby
  "         \ call s:configure_ale_ruby()
  " augroup END
endif

if hz#is#plugged('syntastic')
  " Syntastic
  let g:syntastic_check_on_open = 0
  let g:syntastic_check_on_wq = 0
  let g:syntastic_enable_signs=1
  let g:syntastic_error_symbol = '✗'
  let g:syntastic_warning_symbol = '⚠'
  let g:syntastic_ruby_mri_exec = expand('~/.rubies/ruby-2.2.2/bin/ruby')
  let g:syntastic_ruby_rubocop_exe = g:syntastic_ruby_mri_exec . ' -S rubocop'
  " let g:syntastic_ruby_rubylint_exe = g:syntastic_ruby_mri_exec . ' -S ruby-lint'
  let g:syntastic_ruby_checkers = [ 'mri', 'rubocop' ]
  let g:syntastic_javascript_checkers = [ 'eslint' ]
  " let g:syntastic_javascript_eslint_exec = 'eslint_d'
  let g:syntastic_vim_checkers = ['vint']
endif
