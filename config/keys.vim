scriptencoding utf-8

" Override the default K binding to search for a word in the current directory.
" Use the location window for matches.
nnoremap K :silent lgrep! -w '<C-R><C-W>'<CR>:lw<CR>
xnoremap K :silent lgrep! -w '<C-R><C-W>'<CR>:lw<CR>

" Visual indent reselects the selected text.
xnoremap > >gv
xnoremap < <gv

" Insert a <Tab> with <C-t> rather than <C-v><Tab>.
inoremap <C-t> <C-v><Tab>

" Disable ex-mode shortcut.
nnoremap Q <Nop>

" Reselect the last changed text.
nnoremap gz `[v`]

" Move the view to the top/centre/bottom
noremap <expr> zz (winline() == (winheight(0) + 1) / 2) ?
      \ 'zt' : (winline() == 1)? 'zb' : 'zz'

" Center the viewport when jumping around.
nnoremap g; g;zz
nnoremap g, g,zz

" Keep search matches in the middle of the window and pulse the line when
" moving to them.
nnoremap <silent> n nzzzv:call hz#ui#_pulse_cursor_line(4, 20, 5)<CR>
nnoremap <silent> N Nzzzv:call hz#ui#_pulse_cursor_line(4, 20, 5)<CR>
augroup hsautocmd-pulse
  autocmd!
  autocmd FocusGained * call hz#ui#_pulse_cursor_line(4, 20, 5)
augroup END

" Make CTRL-^ rebound to the line and column in the alternate file.
noremap <C-^> <C-^>`"

" Show more information under <C-G>.
noremap <C-G> 2<C-G>

" Use the visual mode selection to set the search for */# searches.
xnoremap <silent> * :<C-U>call hz#ui#_v_set_search()<CR>//<CR><C-O>
xnoremap <silent> # :<C-U>call hz#ui#_v_set_search()<CR>??<CR><C-O>

" Don't move on */#
nnoremap * *<C-O>
nnoremap # #<C-O>

" Duplicate the current selection.
xnoremap D y'>p

" Insert the path of the currently edited file into a command.
cmap <C-R><C-P> <C-R>=expand("%:p:h") . "/"<CR>

" {{{1 Folding maps
" <Tab> opens/closes the outermost fold.
map <Tab> za
" <Shift-Tab> opens/closes all folds, recursively.
map <S-Tab> zA

" Make zO recursively open whatever top level fold we're in, no matter where
" the cursor happens to be.
nnoremap zO zCzO
xnoremap zO zCzO

" Use <Leader>z to "focus" the current fold.
nnoremap <Leader>z zMzvzz
" }}}1

" Specify the last changed text as `{motion}`.
xnoremap <silent> gz :<C-U>normal gz<CR>
onoremap <silent> gz :<C-U>normal gz<CR>

" Make it easy to get into the command-line editor buffer with ';;' by making
" some plug-style private mappings.
nnoremap <SID>(command-line-enter) q:
xnoremap <SID>(command-line-enter) q:
nnoremap <SID>(command-line-norange) q:<C-U>
" Next, use these private mappings. This makes it harder to override.
nmap ;; <SID>(command-line-enter)
xmap ;; <SID>(command-line-enter)

" {{{1 [Space] as a leader:
" Treat normal mode <Space> and <S-Space> as a type of <Leader>, similar to
" spacemacs or spacevim. Space by itself wil be a <Nop> on timeout.
nmap <Space> [Space]
xmap <Space> [Space]
nmap <S-Space> [Space]
xmap <S-Space> [Space]
nnoremap [Space] <Nop>
xnoremap [Space] <Nop>

" Start a :Shell command
nnoremap [Space]! :Shell<Space>

" {{{2 [Space]c… :
" Change the local cwd to the directory of the current buffer.
nnoremap <silent> [Space]cd :<C-u>CDToBufferDir<CR>
" }}}2

" {{{ [Space]d… :
" Toggle the diff options to include or exclude whitespace
nnoremap <silent> [Space]dw :<C-u>call hz#ui#_toggle_diff_iwhite<CR>

" {{{2 [Space]f… :
" Jump folds.
nnoremap <silent> [Space]fj zj
nnoremap <silent> [Space]fk zk
" }}}2

" {{{2 [Space]g… :
" Toggle g[jk]
noremap <silent> [Space]gj :<C-u>ToggleGJK<CR>
" }}}2

" {{{2 [Space]t… :
" Change tab width locally.
" Change tab width.
nnoremap <silent> [Space]t2 :<C-U>setlocal shiftwidth=2 softtabstop=2<CR>
nnoremap <silent> [Space]t4 :<C-U>setlocal shiftwidth=4 softtabstop=4<CR>
nnoremap <silent> [Space]t8 :<C-U>setlocal shiftwidth=8 softtabstop=8<CR>
" }}}2

" {{{2 [Space]H… :
" Set keyword lookup to be vim help. Because of the binding above, remap this
" behaviour to <Leader>K (\K by default).
nnoremap <silent> [Space]H K
xnoremap <silent> [Space]H K
" }}}2
" }}}1

" {{{1 [Quickfix] as a leader:
" Treat normal mode q as a type of <Leader>. q by itself wil be a <Nop> on
" timeout.
nmap q [Quickfix]
nnoremap [Quickfix] <Nop>

" [Quickfix]/ - Open a quickfix window for the last search.
nnoremap [Quickfix]/ :execute 'vimgrep /' . @/ . '/g %'<CR>:copen<CR>

" [Quickfix]q - Toggle quickfix window.
nnoremap <silent> [Quickfix]q :<C-U>ToggleQuickfixWindow<CR>
" [Quickfix]n - next quickfix item
nnoremap <silent> [Quickfix]n :<C-U>cnext<CR>
" [Quickfix]p - previous quickfix item
nnoremap <silent> [Quickfix]p :<C-U>cprevious<CR>

" vim:set foldmethod=marker
