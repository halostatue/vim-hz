scriptencoding utf-8

" This default only makes sense for VIM, so it needs to move to a vim
" autogroup and be setlocal. The default ('man -s') isn't very useful, either.
" set keywordprg=:help
"
" Use vim-jp/autofmt if present.
if hs#plug#in('autofmt')
  set formatexpr=autofmt#compat#formatexpr()
endif

" Set the default tabline.
  MOVE TO terminal
let &tabline='%!hz#ui#tabline()'


" This is temporarily disabled. I’ll probably bring it back in a separate
" configuration, or more likely provide explicit 'copy to clipboard' commands.
if (has('gui_running') || has('xterm_clipboard')) && hz#get_setting('os_clipboard')
  if has('unnamedplus')
    set clipboard& clipboard+=unnamedplus
  else
    set clipboard& clipboard+=unnamed
  endif
endif

function! hz#reset_on_filetype() abort
  " Disable automatically insert comment.
  setlocal formatoptions-=ro formatoptions+=mMBl

  " Disable auto wrap.
  if &l:textwidth != 70 && &filetype !=# 'help'
    setlocal textwidth=0
  endif

  if &filetype !=# 'help' | call hz#smart_foldtext() | endif

  if !&l:modifiable
    setlocal nofoldenable
    setlocal foldcolumn=0

    if v:version >= 703
      setlocal colorcolumn=
    endif
  endif
endfunction

function! hz#download_thesaurus(force) abort
  if hz#is#windows()
    let l:path = expand('~/vimfiles/thesaurus/mthesaur.txt')
  else
    let l:path = expand('~/.vim/thesaurus/mthesaur.txt')
  endif
  let l:url = 'https://raw.githubusercontent.com/zeke/moby/master/words.txt'
  let l:download = empty(glob(l:path))
  if a:force ==# '!' | let l:download = 1 | endif

  if l:download
    echo 'Downloading the Moby thesaurus…'
    let l:command = '!curl -fLo ' . l:path . ' --create-dirs ' . l:url
    silent execute l:command
  endif
endfunction

let g:SimpleJsIndenter_BriefMode=1
let g:SimpleJsIndenter_CaseIndentLevel=-1

" http://mattn.kaoriya.net/software/vim/20140523124903.htm
let g:vim_markdown_no_default_key_mappings=0

let g:fieldtrip_start_map='Gs'

let g:switch_mapping=''

let g:whitespaste_before_mapping = ''
let g:whitespaste_after_mapping  = ''

let g:multichange_mapping        = '[Space]M'
let g:multichange_motion_mapping = 'm'

augroup hsautocmd-schemesyntax
  autocmd!

  " Enable gauche syntax for scheme.
  autocmd FileType scheme nested let b:is_gauche=1 |
        \ setlocal lispwords=define | let b:current_syntax='' | syntax enable
augroup END

augroup hsautocmd-switch
  autocmd!

  autocmd FileType tex,plaintex let b:switch_custom_definitions =
        \ [
        \    [
        \      '\\tiny', '\\scriptsize', '\\footnotesize', '\\small',
        \      '\\normalsize', '\\large', '\\Large', '\\LARGE', '\\huge',
        \      '\\Huge'
        \    ],
        \    [ '\\displaystyle', '\\scriptstyle', '\\scriptscriptstyle', '\\textstyle' ],
        \    [
        \      '\\part', '\\chapter', '\\section', '\\subsection',
        \      '\\subsubsection', '\\paragraph', '\\subparagraph'
        \    ],
        \    [ 'part:', 'chap:', 'sec:', 'subsec:', 'subsubsec:' ],
        \    [ 'article', 'report', 'book', 'letter', 'slides' ],
        \    [
        \      'a4paper', 'a5paper', 'b5paper', 'executivepaper', 'legalpaper',
        \      'letterpaper', 'beamer', 'subfiles', 'standalone'
        \    ],
        \    [ 'onecolumn', 'twocolumn' ],
        \    [ 'oneside', 'twoside' ],
        \    [ 'draft', 'final' ],
        \    [ 'AnnArbor', 'Antibes', 'Bergen', 'Berkeley',
        \      'Berlin', 'Boadilla', 'CambridgeUS', 'Copenhagen', 'Darmstadt',
        \      'Dresden', 'Frankfurt', 'Goettingen', 'Hannover', 'Ilmenau',
        \      'JuanLesPins', 'Luebeck', 'Madrid', 'Malmoe', 'Marburg',
        \      'Montpellier', 'PaloAlto', 'Pittsburgh', 'Rochester', 'Singapore',
        \      'Szeged', 'Warsaw' ]
        \ ]

  autocmd FileType gitrebase let b:switch_custom_definitions =
        \ [
        \   [ 'pick', 'reword', 'edit', 'squash', 'fixup', 'exec' ]
        \ ]

  autocmd FileType erlang let b:switch_custom_definitions =
        \ [
        \   {
        \     '<<"\([^"]*\)">>':       '"\1"',
        \     '\%(<<\)\@<!"\([^"]*\)"': '<<"\1">>',
        \   }
        \ ]

  autocmd FileType elixir let b:switch_custom_definitions =
        \ [
        \   {
        \     '<<"\([^"]*\)">>':       '"\1"',
        \     '\%(<<\)\@<!"\([^"]*\)"': '<<"\1">>',
        \   }
        \ ]
augroup END


augroup hsautocmd-dirvish
  autocmd!
  autocmd FileType dirvish call fugitive#detect(@%)
augroup END

function! s:plug_doc()
  let l:name = matchstr(getline('.'), '^- \zs\S\+\ze:')
  if hs#plug#in(l:name)
    for l:doc in split(globpath(g:plugs[l:name].dir, 'doc/*.txt'), '\n')
      execute 'tabe' l:doc
    endfor
  endif
endfunction

function! s:plug_gx()
  let l:line = getline('.')
  let l:sha  = matchstr(l:line, '^  \X*\zs\x\{7}\ze ')
  let l:name = empty(l:sha) ? matchstr(l:line, '^[-x+] \zs[^:]\+\ze:')
                      \ : getline(search('^- .*:$', 'bn'))[2:-2]
  let l:uri  = get(get(g:plugs, l:name, {}), 'l:uri', '')
  if l:uri !~# 'github.com'
    return
  endif
  let l:repo = matchstr(l:uri, '[^:/]*/'.l:name)
  let l:url  = empty(l:sha) ? 'https://github.com/'.l:repo
                      \ : printf('https://github.com/%s/commit/%s', l:repo, l:sha)
  call netrw#BrowseX(l:url, 0)
endfunction

function! s:plug_scroll_preview(down)
  silent! wincmd P
  if &previewwindow
    execute 'normal!' a:down ? "\<c-e>" : "\<c-y>"
    wincmd p
  endif
endfunction

function! s:plug_setup_extra_keys()
  nnoremap <silent> <buffer> J :call <sid>plug_scroll_preview(1)<cr>
  nnoremap <silent> <buffer> K :call <sid>plug_scroll_preview(0)<cr>
  nnoremap <silent> <buffer> <c-n> :call search('^  \X*\zs\x')<cr>
  nnoremap <silent> <buffer> <c-p> :call search('^  \X*\zs\x', 'b')<cr>
  nmap <silent> <buffer> <c-j> <c-n>o
  nmap <silent> <buffer> <c-k> <c-p>o
endfunction

augroup hsautocmd-vim-plug
  autocmd!
  autocmd FileType vim-plug nnoremap <buffer> <silent> H :call <sid>plug_doc()<cr>
  autocmd FileType vim-plug call s:plug_setup_extra_keys()
  autocmd FileType vim-plug nnoremap <buffer> <silent> gx :call <sid>plug_gx()<cr>
augroup END
