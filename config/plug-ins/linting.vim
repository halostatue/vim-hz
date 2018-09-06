scriptencoding utf-8

if hz#is#plugged('neomake')
  if hz#plugins#has('neomake_maybe_use_bundler')
    call neomake#config#set('ft.ruby.InitForJob',
          \ function('hz#plugins#_neomake_maybe_use_bundler'))
  endif

  if hz#on_battery()
    call neomake#configure#automake('w')
  else
    call neomake#configure#automake('nrw', 1000)
  endif

  let g:quickfixsigns_protect_sign_rx = '^neomake_'

  let g:neomake_elixir_enabled_makers = ['mix', 'credo']
  let g:neomake_open_list = 2
endif

if hz#is#plugged('asyncomplete.vim')
  augroup hz-asyncomplete-setup
    autocmd!

    if hz#is#plugged('asyncomplete-buffer.vim')
      autocmd User asyncomplete_setup
            \ call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
            \   'name': 'buffer',
            \   'whitelist': ['*'],
            \   'blacklist': ['go'],
            \   'completor': function('asyncomplete#sources#buffer#completor'),
            \ }))
    endif

    if hz#is#plugged('asyncomplete-emoji.vim')
      autocmd User asyncomplete_setup
            \ call asyncomplete#register_source(asyncomplete#sources#emoji#get_source_options({
            \   'name': 'emoji',
            \   'whitelist': ['*'],
            \   'completor': function('asyncomplete#sources#emoji#completor'),
            \ }))
    endif

    if hz#is#plugged('asyncomplete-file.vim')
      autocmd User asyncomplete_setup
            \ call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
            \   'name': 'file',
            \   'whitelist': ['*'],
            \   'priority': 10,
            \   'completor': function('asyncomplete#sources#file#completor')
            \ }))
    endif

    if hz#is#plugged('asyncomplete-gocode.vim')
      autocmd User asyncomplete_setup
            \ call asyncomplete#register_source(asyncomplete#sources#gocode#get_source_options({
            \   'name': 'gocode',
            \   'whitelist': ['go'],
            \   'completor': function('asyncomplete#sources#gocode#completor'),
            \ }))
    endif

    if hz#is#plugged('asyncomplete-flow.vim')
      autocmd User asyncomplete_setup
            \ call asyncomplete#register_source(asyncomplete#sources#flow#get_source_options({
            \   'name': 'flow',
            \   'whitelist': ['javascript'],
            \   'completor': function('asyncomplete#sources#flow#completor'),
            \   'config': {
            \    'prefer_local': 1,
            \    'show_typeinfo': 1
            \  },
            \ }))
    endif

    if hz#is#plugged('asyncomplete-neosnippet.vim', 'neosnippet.vim')
      autocmd User asyncomplete_setup
            \ call asyncomplete#register_source(asyncomplete#sources#neosnippet#get_source_options({
            \   'name': 'neosnippet',
            \   'whitelist': ['*'],
            \   'completor': function('asyncomplete#sources#neosnippet#completor'),
            \ }))
      imap <C-k> <Plug>(neosnippet_expand_or_jump)
      smap <C-k> <Plug>(neosnippet_expand_or_jump)
      xmap <C-k> <Plug>(neosnippet_expand_target)
    endif

    if hz#is#plugged('asyncomplete-omni.vim')
      autocmd User asyncomplete_setup
            \ call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
            \   'name': 'omni',
            \   'whitelist': ['*'],
            \   'blacklist': ['c', 'cpp', 'html'],
            \   'completor': function('asyncomplete#sources#omni#completor')
            \ }))
    endif

    if hz#is#plugged('asyncomplete-racer.vim')
      autocmd User asyncomplete_setup
            \ call asyncomplete#register_source(asyncomplete#sources#racer#get_source_options())
    endif

    if hz#is#plugged('tmux-complete.vim')
      let g:tmuxcomplete#asyncomplete_source_options = {
            \ 'name': 'tmuxcomplete',
            \ 'whitelist': ['*'],
            \ 'config': {
            \     'splitmode': 'words',
            \     'filter_prefix': 1,
            \     'show_incomplete': 1,
            \     'sort_candidates': 0,
            \     'scrollback': 0,
            \     'truncate': 0
            \     }
            \ }
    endif

    if hz#is#plugged('asyncomplete-tscompletejob.vim')
      autocmd User asyncomplete_setup
            \ call asyncomplete#register_source(
            \   asyncomplete#sources#tscompletejob#get_source_options({
            \     'name': 'tscompletejob',
            \     'whitelist': ['typescript'],
            \     'completor': function('asyncomplete#sources#tscompletejob#completor'),
            \ }))
    endif

    if hz#is#plugged('asyncomplete-ultisnips.vim')
      let g:UltiSnipsExpandTrigger='<c-e>'
      autocmd User asyncomplete_setup
            \ call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
            \   'name': 'ultisnips',
            \   'whitelist': ['*'],
            \   'completor': function('asyncomplete#sources#ultisnips#completor'),
            \ }))
    endif

    if hz#is#plugged('asyncomplete-necosyntax.vim')
      autocmd User asyncomplete_setup
            \ call asyncomplete#register_source(asyncomplete#sources#necosyntax#get_source_options({
            \   'name': 'necosyntax',
            \   'whitelist': ['*'],
            \   'completor': function('asyncomplete#sources#necosyntax#completor'),
            \ }))
    endif

    if hz#is#plugged('asyncomplete-tags.vim')
      autocmd User asyncomplete_setup
            \ call asyncomplete#register_source(asyncomplete#sources#tags#get_source_options({
            \   'name': 'tags',
            \   'whitelist': ['c'],
            \   'completor': function('asyncomplete#sources#tags#completor'),
            \   'config': {
            \     'max_file_size': 50000000,
            \   },
            \ }))
    endif

    if hz#is#plugged('asyncomplete-necovim.vim')
      autocmd User asyncomplete_setup
            \ call asyncomplete#register_source(asyncomplete#sources#necovim#get_source_options({
            \   'name': 'necovim',
            \   'whitelist': ['vim'],
            \   'completor': function('asyncomplete#sources#necovim#completor'),
            \ }))
    endif
  augroup END
endif

if hz#is#plugged('vim-lsp')
  augroup hz-lsp-setup
    autocmd!

    if executable('css-languageserver')
      autocmd User lsp_setup call lsp#register_server({
            \   'name': 'css-languageserver',
            \   'cmd': {server_info->[&shell, &shellcmdflag, 'css-languageserver --stdio']},
            \   'whitelist': ['css', 'less', 'sass'],
            \ })
    endif

    if executable('docker-langserver')
      autocmd User lsp_setup call lsp#register_server({
            \   'name': 'docker-langserver',
            \   'cmd': {server_info->[&shell, &shellcmdflag, 'docker-langserver --stdio']},
            \   'whitelist': ['dockerfile'],
            \ })
    endif

    if executable('flow-language-server')
      autocmd User lsp_setup call lsp#register_server({
            \   'name': 'flow-language-server',
            \   'cmd': {server_info->[&shell, &shellcmdflag, 'flow-language-server --stdio']},
            \   'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), '.flowconfig'))},
            \   'whitelist': ['javascript', 'javascript.jsx'],
            \ })
    endif

    if executable('go-langserver')
      autocmd User lsp_setup call lsp#register_server({
            \   'name': 'go-langserver',
            \   'cmd': {server_info->['go-langserver', '-mode', 'stdio']},
            \   'whitelist': ['go'],
            \ })
    endif

    if executable('pyls')
      autocmd User lsp_setup call lsp#register_server({
            \   'name': 'pyls',
            \   'cmd': {server_info->['pyls']},
            \   'whitelist': ['python'],
            \   'workspace_config': {'pyls': {'plugins': {'pydocstyle': {'enabled': v:true}}}}
            \ })
    endif

    if executable('solargraph')
      " gem install solargraph
      autocmd User lsp_setup call lsp#register_server({
            \   'name': 'solargraph',
            \   'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
            \   'initialization_options': {"diagnostics": "true"},
            \   'whitelist': ['ruby'],
            \ })
    endif

    if executable('rls')
      autocmd User lsp_setup call lsp#register_server({
            \   'name': 'rls',
            \   'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
            \   'whitelist': ['rust'],
            \ })
    endif

    if executable('typescript-language-server')
      autocmd User lsp_setup call lsp#register_server({
            \   'name': 'typescript-language-server',
            \   'cmd': { server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
            \   'root_uri': { server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_directory(lsp#utils#get_buffer_path(), '.git/..'))},
            \   'whitelist': ['typescript', 'javascript', 'javascript.jsx']
            \ })
    endif

    if executable('ocaml-language-server')
      autocmd User lsp_setup call lsp#register_server({
            \   'name': 'ocaml-language-server',
            \   'cmd': {server_info->[&shell, &shellcmdflag, 'opam config exec -- ocaml-language-server --stdio']},
            \   'whitelist': ['reason', 'ocaml'],
            \ })
    endif

    " if executable('elixir-ls')
    "   autocmd User lsp_setup call lsp#register_server({
    "         \   'name': 'elixir-ls',
    "         \   'cmd': {server_info->[&shell, &shellcmdflag, 'elixir-ls']},
    "         \   'whitelist': ['elixir', 'eelixir'],
    "         \ })
    " endif
  augroup END

  " let g:lsp_signs_enabled = 1
  " let g:lsp_diagnostics_echo_cursor = 1
  " let g:lsp_log_verbose = 1
  " let g:lsp_log_file = expand('~/vim-lsp.log')
  " let g:asyncomplete_log_file = expand('~/asyncomplete.log')
endif

if hz#is#plugged('LanguageClient-neovim')
  let s:sc = {}

  if executable('css-languageserver')
    let s:sc['css'] = ['css-languageserver', '--stdio']
    let s:sc['sass'] = s:sc['css']
    let s:sc['less'] = s:sc['css']
  endif

  if executable('flow-language-server')
    let s:sc['javascript'] = ['flow-language-server', '--stdio']
    let s:sc['javascript.jsx'] = s:sc['javascript']
  endif

  if executable('go-langserver')
    let s:sc['go'] = ['go-langserver', '-mode', 'stdio']
  endif

  if executable('pyls')
    let s:sc['python'] = ['pyls']
  endif

  if executable('solargraph')
    let s:sc['ruby'] = ['solargraph', 'stdio']
  endif

  if executable('rls')
    let s:sc['ruby'] = ['rustup', 'run', 'nightly', 'rls']
  endif

  if executable('typescript-language-server')
    let s:sc['typescript'] = ['typescript-language-server', '--stdio']
    " let s:sc['javascript'] = s:sc['typescript']
    " let s:sc['javascript.jsx'] = s:sc['typescript']
  endif

  if executable('ocaml-language-server')
    let s:sc['ocaml'] = ['opam', 'config', 'exec', '--', 'ocaml-language-server', '--stdio']
    let s:sc['reason'] = s:sc['ocaml']
  endif

  if executable('elixir-ls')
    let s:sc['elixir'] = ['elixir-ls']
  endif

  let g:LanguageClient_serverCommands = s:sc
  unlet s:sc
endif
