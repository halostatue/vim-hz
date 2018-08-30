scriptencoding utf-8

set number " Show line numbers all the time
set hlsearch " Show search highlighting

set diffopt-=iwhite " Remove whitespace sensitivity in diffs by default

set noshowcmd " Do not show partial command on the last line of the string.

" Sensible search: caseless unless there's a cased string in the pattern.
set ignorecase smartcase

" Turn on the window title and make it a little more useful.
if has('title')
  set title titlelen=95
  " The the title to FILE FLAGS (CWD) - SERVER
  "
  " - FILE: The minimum path to the file relative to the CWD.
  " - FLAGS: Modified and/or preview state of the file (may be empty)
  " - CWD: The (possibly) truncated current directory, relative to $HOME.
  " - SERVER: The current Vim server name (or VIM)
  let &titlestring =
        \  '%{expand("%:p:~:.")} %(%m%w%) %<'
        \. '(%{printf("%.*S", &columns - len(expand("%:p:~:."))'
        \. ', fnamemodify(getcwd(), ":~"))}) - %{v:servername}'
endif

set showtabline=1 " Show the tabline when there are two or more tab pages.

" Set the default global status line to:
"
"   BUF FILE FLAGS SCM SYNTAX ASYNC SEARCH SEP POS PCT
"
" - BUF: The buffer number as [x/y] where y is the total number of opened
"   buffers, including hidden buffers.
" - FILE: The filename, up to 99 characters, relative to current directory if
"   possible.
" - FLAGS: Various modifiers for the buffer type. See
"   @function(hz#ui#status#filemodifiers) for more information. May also use
"   the standard %q (quickfix/location list) display or flag whether the
"   window is a preview window.
" - SCM: Show the current SCM status, if possible. Currently only Fugitive is
"   supported, and only if it's installed.
" - SYNTAX: If there are any syntax errors reported by a syntax checker
"   (scrooloose/syntastic or w0rp/ALE), report here.
" - ASYNC: Returns the value of skywind3000/asyncrun, if set.
" - SEARCH: If the there is search status to return (such as by
"   osyo-manga/anzu), return it. Typically this is x/y matches.
" - SEP: Separate left/right data.
" - POS: Show the cursor position as COL[-VCOL],LINE/LINES
" - PCT: Show the percentage of position in the file.
let &g:statusline =
      \  '%{hz#ui#status#buffer()} '
      \. '%<%.99f %(%{hz#ui#status#filemodifiers()}%q%{hz#ui#status#preview()}%)'
      \. '%{hz#ui#status#scm()}'
      \. '%#errorMsg#%{hz#ui#status#syntax()}%*'
      \. '%{hz#ui#status#asyncrun()}'
      \. '%{hz#ui#status#search()}'
      \. '%{hz#ui#status#conflicted()}'
      \. '%{hz#ui#status#capslock()}'
      \. '%='
      \. '%-14.(%c%V,%l/%L%) %P'

" Set linebreaking and wrapping rules.
if has('linebreak')
  set wrap linebreak showbreak=↪ whichwrap=b,s,h,l,<,>,~,[,]
  if exists('+breakindent') | set breakindent | endif
else
  set nowrap
endif

" Do not show the mode, e.g., -- INSERT --, at the bottom.
set noshowmode

" Help avoid 'hit-enter' messages. See 'shortmess' for the options and their
" meanings.
set shortmess=aTIoc

" Handle wildmenu matching
if has('wildmenu')
  " Set the wildchar for use in a macro
  set wildcharm=<C-Z>
  " Set the command-completion mode:
  " 1. show list, completing the longest common string
  " 2. show list, completing the next full match
  set wildmode=list:longest,list:full

  if has('wildignore')
    " Ignore the following file patterns when completing files.
    set wildignore+=.hg,.git,.svn                  " Version control
    set wildignore+=*.aux,*.out,*.toc              " LaTeX intermediate files
    set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg " binary images
    set wildignore+=*.o,*.obj,*.exe,*.dll          " compiled object files
    set wildignore+=*.manifest,*.so,*.dylib        " compiled object files
    set wildignore+=*.class                        " compiled object files
    set wildignore+=*.spl                          " compiled spelling lists
    set wildignore+=*.sw?                          " Vim swap files
    set wildignore+=*.DS_Store                     " macOS Finder bullshit
    set wildignore+=*.luac                         " Lua byte code
    set wildignore+=*.pyc                          " Python byte code
    set wildignore+=*.rbc                          " Rubinius byte code

    " Other versions should be loaded in language-specific files (e.g,
    " ignoring _build directories in Elixir projects).

    " Can supplement a tag in a command-line.
    set wildoptions=tagfile
  endif
endif

" Don't show relative numbers by default. There are plug-ins that may override
" this, particularly ones that switch between absolute and relative numbering
" during mode changes.
set norelativenumber

" Show the tag name and search pattern both for tag completion.
set showfulltag

" Don't force all windows to equal size on splitting or closing.
set noequalalways

" Let macros run faster by not updating the screen during update.
set nolazyredraw

" Let windows be squeezed just their status bar (horizontal splits) or the
" separator (vertical splits). Also make the help window a minimum of 10 rows
" instead of 20.
set winminheight=0 winminwidth=0 helpheight=10

" The file browser starts from the directory of the current directory, not the
" current buffer.
set browsedir=current
