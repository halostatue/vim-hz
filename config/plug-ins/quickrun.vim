scriptencoding utf-8

if hz#is#plugged('vim-quickrun')
  if !has_key(g:, 'quickrun_config') | let g:quickrun_config = {} | endif

  if hz#is#plugged('vim-qrpsqlpq')
    augroup quickrun-qrpsqlpq
      autocmd!
      autocmd FileType sql call hz#plugins#_init_quickrun_psqlpq()
    augroup END
  endif

  if hz#is#plugged('vim-quickrun-hook-unittest')
    augroup quickrun-unittest-hook
      autocmd!

      " autocmd BufWinEnter,BufNewFile *test.php setlocal filetype=php.unit
      " Choose UnitTest, py.test or Django.
      " autocmd BufWinEnter,BufNewFile test_*.py setlocal filetype=python.unit
      " autocmd BufWinEnter,BufNewFile test_*.py setlocal filetype=python.pytest
      " autocmd BufWinEnter,BufNewFile test_*.py setlocal filetype=python.django
      " autocmd BufWinEnter,BufNewFile *.t       setlocal filetype=perl.unit
      autocmd BufWinEnter,BufNewFile *_spec.rb setlocal filetype=ruby.rspec
      autocmd BufWinEnter,BufNewFile *_test.rb setlocal filetype=ruby.minitest
      autocmd BufWinEnter,BufNewFile *_test.go setlocal filetype=go.test
      autocmd BufWinEnter,BufNewFile *.test.js setlocal filetype=javascript.mocha
      autocmd BufWinEnter,BufNewFile *_test.exs setlocal filetype=elixir.test
    augroup END

    call extend(g:quickrun_config, {
          \   'php.unit': { 'command': 'testrunner', 'cmdopt': 'phpunit' },
          \   'python.unit': { 'command': 'nosetests', 'cmdopt': '-v -s' },
          \   'python.pytest': { 'command': 'py.test', 'cmdopt': '-v' },
          \   'python.django': {'command': 'python', 'cmdopt': 'test --parallel --keepdb'},
          \   'ruby.rspec': { 'command': 'rspec', 'cmdopt': '-f d' },
          \   'ruby.minitest': { 'command': 'ruby' },
          \   'go.test': { 'command': 'go', 'cmdopt': 'test -v' },
          \   'javascript.mocha': { 'command': 'mocha' },
          \   'elixir.test': { 'command': 'mix', 'cmdopt': 'test', 'hook/unittest/enable': 1 }
          \ })

    " nnoremap <silent> <Leader>r :QuickRun -mode n -runner job -hook/unittest/enable 1<CR>
  endif
endif
