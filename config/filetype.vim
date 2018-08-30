scriptencoding utf-8

if has('smartindent') | set smartindent | endif

let g:c_ansi_constants = 1
let g:c_ansi_typedefs = 1
let g:c_comment_strings = 1
let g:c_gnu = 1
let g:c_space_errors = 1
let g:changelog_spacing_errors = 1
let g:clojure_fold = 1
let g:d_comment_strings = 1
let g:d_hl_object_types = 1
let g:d_hl_operator_overload = 1
let g:doxygen_enhanced_colour = 1
let g:forth_space_errors = 1
let g:hs_allow_hash_operator = 1
let g:hs_highlight_boolean = 1
let g:hs_highlight_debug = 1
let g:hs_highlight_delimiters = 1
let g:hs_highlight_more_types = 1
let g:hs_highlight_types = 1
let g:html_extended_events = 1
let g:java_comment_strings = 1
let g:java_highlight_all = 1
let g:java_highlight_functions = 'style'
let g:java_space_errors = 1
let g:javaScript_fold=1
let g:lisp_instring = 1
let g:lisp_rainbow = 1
let g:lispsyntax_clisp = 1
let g:perl_include_pod = 1
let g:perl_fold = 1
let g:perl_fold_blocks = 1
let g:perl6_extended_all = 1
let g:perl6_embedded_pir = 1
let g:php_sql_query = 1
let g:php_baselib = 1
let g:php_htmlInStrings = 1
let g:php_noShortTags = 1
let g:php_parent_error_close = 1
let g:php_parent_error_open = 1
let g:php_folding = 2
let g:python_highlight_all = 1
let g:python_highlight_builtins = 1
let g:r_syntax_folding = 1
let g:readline_has_bash = 1
let g:ruby_operators = 1
let g:ruby_space_errors = 1
let g:ruby_fold = 1
let g:is_bash = 1 " Default to bash scripts when shell files are loaded.
let g:sh_fold_enabled = 7 " bitmask: 1 functions, 2 heredoc, 4 if/do/fo
let g:tex_fold_enabled = 1
let g:tex_comment_nospell = 1
let g:tex_stylish = 1
let g:plaintex_delimiters = 1
let g:vimsyn_embed = 'lmpPrt'
let g:vimsyn_folding = 'alfmpPrt'
let g:xml_syntax_folding = 1
let g:zsh_fold_enable = 1

let g:markdown_fenced_languages =
      \ [
      \   'css',
      \   'erb=eruby',
      \   'javascript',
      \   'js=javascript',
      \   'json=javascript',
      \   'ruby',
      \   'sass',
      \   'xml',
      \   'vim',
      \ ]

if $GOROOT !=# '' && isdirectory(expand('$GOROOT/misc/vim'))
  set runtimepath+=$GOROOT/misc/vim
endif

function! s:vimscript_user_commands()
  redir => l:commands
  silent! command
  redir END

  let l:commands =
        \ join(
        \   map(
        \     split(l:commands, '\n')[1:],
        \     { _, v -> matchstr(v, '[!"b]*\s\+\zs\u\w*\ze') }))

  if empty(l:commands)
    return
  else
    execute 'syntax keyword vimCommand' l:commands
  endif
endfunction

augroup hzvim_autocmd_vimscript_syntax
  autocmd!

  " Add syntax highlighting for user-defined commands.
  autocmd Syntax vim call s:vimscript_user_commands()
  " Set folding to syntax
  autocmd FileType vim setlocal foldmethod=syntax

  " The following are disabled as they are generally more trouble than they are
  " worth.
  if 0
    " Automatically load .vimrc source when saved
    autocmd BufWritePost
          \ .vimrc,_vimrc,~/.vim/config/*.vim
          \ nested source $MYVIMRC
    autocmd BufWritePost
          \ .gvimrc,_gvimrc,~/vim/config/*.g.vim
          \ nested source $MYGVIMRC

    autocmd BufWritePost,FileWritePost *.vim nested
          \  if &autoread
          \|   source <afile>
          \|   echo 'source ' . bufname('%')
          \| endif
  endif
augroup END

function! s:omni(fn)
  if exists(printf('*%s', a:fn)) | let &l:omnifunc=a:fn | endif
endfunction

augroup hzvim_autocmd_filetype_omnicompletes
  autocmd!
  autocmd FileType ada call s:omni('adacomplete#Complete')
  autocmd FileType c,cpp,objc,obcpp call s:omni('ccomplete#Complete')
  autocmd FileType css call s:omni('csscomplete#CompleteCSS')
  autocmd FileType html,markdown call s:omni('htmlcomplete#CompleteTags')
  autocmd FileType java call s:omni('javacomplete#Complete')
  autocmd FileType php call s:omni('phpcomplete#CompletePHP')
  if has('python3')
    autocmd FileType python call s:omni('python3complete#Complete')
  else
    autocmd FileType python call s:omni('pythoncomplete#Complete')
  endif
  autocmd FileType ruby call s:omni('rubycomplete#Complete')
  autocmd FileType sql call s:omni('sqlcomplete#Complete')
  autocmd FileType xml call s:omni('xmlcomplete#CompleteTags')
augroup END

augroup hzvim_autocmd_html_syntax
  autocmd!

  " Improved include pattern.
  autocmd FileType html
        \  setlocal includeexpr=substitute(v:fname,'^\\/','','')
        \| setlocal path+=./;/
augroup END

augroup hzvim_autocmd_python_syntax
  autocmd!
  autocmd FileType python setlocal foldmethod=indent
augroup END

augroup hzvim_autocmd_apache_syntax
  autocmd!

  autocmd FileType apache setlocal path+=./;/
augroup END

augroup hzvim_autocmd_go_syntax
  autocmd!

  autocmd FileType go
        \ highlight default link goErr WarningMsg |
        \ match goErr /\<err\>/

  autocmd FileType go setlocal ts=2 sts=2 sw=2 noet ai
augroup END

augroup hzvim_autocmd_git_files
  autocmd!

  " These should not have buftypes set, so clear them.
  autocmd FileType gitcommit,gitconfig,gitrebase,gitsendemail
        \ setlocal buftype=

  autocmd FileType gitrebase nnoremap <buffer> <silent> S :Cycle<CR>
augroup END
