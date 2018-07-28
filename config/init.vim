" Basic vim initialization.

if exists('+shellslash') | set shellslash | endif

" Do not ring the bell for error messages (`noerrorbells`), turn on visual bell
" (`visualbell`), then turn it off (`t_vb=`). Note that when the GUI starts,
" `t_vb` gets reset to `<Esc>|f`, so it may need to be reset in the `gvimrc`.
set noerrorbells visualbell t_vb=

" Prevent several default plug-ins from being loaded, because we don't want
" them.
let g:loaded_2html_plugin = 1 " Disable the TOhtml command.
let g:loaded_getscriptPlugin = 1 " Disable GetLatestVimScripts
let g:loaded_logiPat = 1 " Disable LogiPat
let g:loaded_matchparen = 1 " Disable default matchparen
let g:loaded_netrwPlugin = 1 " Disable netrw and prefer NERD-tree.
let g:loaded_vimballPlugin = 1 " Disable vimballs.

" Automatically install vim-plug, install plugs if the plug list changed.
if has('vim_starting') && !hz#config#exists('autoload/plug.vim')
  echo "Installing vim-plug.\n"
  execute join([
          \   'silent !curl -fLo',
	  \   expand('<sfile>:p:h:h') . '/autoload/plug.vim',
          \   '--create-dirs',
          \   'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
          \ ])
  augroup vim-plug-install
    autocmd!
    autocmd VimEnter *
	  \  if exists(':PlugInstall') == 2
	  \|   PlugInstall --sync | source $MYVIMRC
    	  \| endif
  augroup END
else
  augroup vim-plug-install
    autocmd VimEnter *
          \  if len(filter(values(get(g:, 'plugs', {})), '!isdirectory(v:val.dir)'))
          \|   PlugInstall --sync | q
          \| endif
  augroup END
endif

" Get the value of $PATH from a login shell if MacVim.app was started from the
" Finder.
if has('gui_macvim') && has('gui_running')
  " ps -xc: just the command, not the command-line; including non-terminal
  "         processes
  " grep -wsc: suppress errors; word boundary; count of matches.
  if system('ps -xc | grep -wsc Vim') > 1
    " If your shell is not on this list, it may be just because we have not
    " tested it.  Try adding it to the list and see if it works. If so, please
    " post a note to the vim-mac list!
    if $SHELL =~# '/\(sh\|csh\|bash\|tcsh\|zsh\)$'
      let s:path = system("echo echo VIMPATH'${PATH}' | $SHELL -l")
      let $PATH = matchstr(s:path, 'VIMPATH\zs.\{-}\ze\n')
      unlet s:path
    endif
  endif

  " MacVIM shift+arrow-keys behavior (required in .vimrc)
  " let g:macvim_hig_shift_movement=1
endif

if homebrew#binary('git')
  let g:fugitive_git_executable = homebrew#binary('git')
endif
