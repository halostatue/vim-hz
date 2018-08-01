scriptencoding utf-8

" Defaults for editing. These are reasonable defaults and do NOT duplicate the
" vim-sensible plug-in.

" Reasonably modern tab settings suitable for most languages.
set tabstop=2 softtabstop=2 shiftwidth=2 shiftround expandtab

set autowrite " Automatically write changed buffers to disk.
set modeline " Turn on the modeline.
set nojoinspaces " One space after punctuation.
set scrolljump=3 " Scroll at least 3 lines for offscreen moves
set keymodel=startsel,stopsel " Start and stop selection with shifted arrows.

" Reasonable match settings.
set showmatch cpoptions-=m matchtime=3 matchpairs+=<:>

set hidden " Display another buffer when current buffer isn't saved.
set infercase " Ignore case on insert completion.

if has('folding')
  " Folding settings.
  set foldenable foldmethod=marker foldcolumn=1 commentstring=#\ %s
  set foldlevelstart=5 foldnestmax=10
end

" Prefer ripgrep, pt or ag over grep for :grep.
if executable('rg')
  let &grepprg='rg --line-number --color never --no-heading $*'
elseif executable('pt')
  let &grepprg='pt --nogroup --nocolor $*'
elseif executable('ag')
  let &grepprg='ag --nogroup --nocolor $*'
else
  let &grepprg='grep -inH $*'
endif

set timeout timeoutlen=600 " Keymapping timeout.
set updatetime=1000 " Crash recovery write every second, and CursorHold event timeout.

let &directory =
      \ join([
      \   hz#cache#for('vim/tmp//'),
      \   '/var/tmp//',
      \   '/tmp//',
      \   '/private/tmp//'
      \ ], ',')

if has('persistent_undo')
  set undofile
  let &undodir = &directory
endif

" Enable virtualedit in visual block mode
set virtualedit+=block

" Do not leave a backup file around, but make all writes safe. Use the swap
" file directory for these files, too.
set nobackup writebackup
let &backupdir=&directory

" Make Vim able to edit crontab files again.
if has('wildignore') && isdirectory('/private/tmp')
  set backupskip+=/private/tmp/*
endif

" = Keyword completion options
" == ins-completion search order: current buffer; other window buffers;
" unloaded buffers; tags; current and included files; spell checking
" dictionary; files in 'dictionary'; files in 'thesaurus'
set complete+=kspell,k,s complete-=w,b,u
if has('insert_expand')
  set completeopt-=preview pumheight=20
endif

set nostartofline " Do not default to start of line.

if has('mksession')
  let &viewdir=hz#cache#for('vim/view')
  set viewoptions-=options viewoptions+=slash,unix
endif

if has('conceal') | set conceallevel=2 concealcursor=iv | endif

if has('syntax')
  set colorcolumn=80,90,100,110
endif

call hz#ui#smart_foldtext()
call hz#toggle#gjk_mapping(1) " Use the alternate mapping for j (gj).
