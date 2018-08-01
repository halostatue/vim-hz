scriptencoding utf-8

call plug#begin(hz#cache#for('vim/plug'))

""
" @private
" If {cond} is true, then [opts] will be used as is, otherwise it will be
" modified to have empty 'on' and 'for' clauses.
"
" Use this as:
"
"     Plug 'plugin/repo', Cond(cond, { 'on': 'Command' })
"
" This function exists only during the sourcing of this file.
"
" @default opts={}
function! Cond(cond, ...)
  let l:opts = get(a:000, 0, {})
  return a:cond ? l:opts : extend(l:opts, { 'on': [], 'for': [] })
endfunction

" {{{1 Generally useful utilities
" {{{2 by tpope - Tim Pope
Plug 'tpope/vim-sensible'
Plug 'tpope/tpope-vim-abolish'
Plug 'tpope/vim-capslock'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
" }}}2
" {{{2 by junegunn - June Gunn
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/vim-slash'
Plug 'junegunn/vim-pseudocl'
      \| Plug 'junegunn/vim-fnr'
" }}}2
" {{{2 by kana - Kana Natsuno
Plug 'kana/vim-smartchr'
Plug 'kana/vim-smartinput' " Plug 'cohama/lexima.vim'
" }}}2
" {{{2 by lambdalisue
Plug 'lambdalisue/vim-foldround'
" }}}2
" {{{2 by Shougo
Plug 'Shougo/context_filetype.vim'
Plug 'Shougo/echodoc.vim'
Plug 'Shougo/echodoc.vim'
" }}}
" {{{2 by thinca
Plug 'thinca/vim-localrc'
" }}}
" {{{2 by tomtom - Tom Link
Plug 'tomtom/tinykeymap_vim'
" }}}2
" {{{2 by vim-jp
Plug 'vim-jp/autofmt'
" }}}2
Plug 'editorconfig/editorconfig-vim'
Plug 'direnv/direnv.vim'
Plug 'chrisbra/unicode.vim'
Plug 'vim-utils/vim-troll-stopper'
Plug 'unblevable/quick-scope'

" {{{2 Project-related tools
" {{{3 Fuzzy Finders
" Plug 'vim-ctrlspace/vim-ctrlspace'
" Plug 'ctrlp/ctrlp.vim'
" {{{4 fzf
if homebrew#isdirectory('opt/fzf')
  let &runtimepath .= ',' . homebrew#path('opt/fzf')
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
endif
" }}}4
" Plug 'yggdroot/leaderf', { 'do': './install.sh' }
" Plug 'srstevenson/vim-picker'
" {{{4 denite
" Plug 'Shougo/denite.nvim'
" Plug 'raghur/fuzzy-denite', { 'do': ':FuzzyDeniteInstall' }
  " call denite#custom#source('_', 'matchers', ['matcher/gofuzzy'])
" }}}4
" Plug 'mattn/vim-fz',
"       \ { 'do': 'go get github.com/mattn/files ; go get github.com/mattn/gof' }
" Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
" Plug 'troydm/asyncfinder.vim'
" }}}3
" {{{3 NERDTree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'AndrewRadev/andrews_nerdtree.vim' " let g:andrews_nerdtree_all = 1
Plug 'chuckfairy/nerdtree-reveal'
Plug 'Nopik/vim-nerdtree-direnter'
Plug 'evandotpro/nerdtree-chmod'
" Plug 'rargo/vim-line-jump' " https://github.com/rargo/vim-line-jump
" Plug 'gabenespoli/vim-cider-vinegar' " https://github.com/gabenespoli/vim-cider-vinegar
" }}}3
Plug 'majutsushi/tagbar'
Plug 'justinmk/vim-gtfo'
Plug 'tyru/open-browser.vim'
" }}}2
" {{{2 Version Control
" {{{3 Fugitive
Plug 'tpope/vim-fugitive'
      \| Plug 'tpope/vim-rhubarb'
      \| Plug 'junegunn/gv.vim', { 'on': 'GV' }
      \| Plug 'gregsexton/gitv', { 'on': 'Gitv' }
" }}}3
Plug 'rhysd/committia.vim'
Plug 'jlfwong/vim-mercenary'
Plug 'lambdalisue/gina.vim', { 'on': 'Gina' }
" }}}2

" }}}1
" {{{2 by romainl - Romain Lafourcade
Plug 'romainl/vim-qf'
Plug 'romainl/vim-qlist'
" }}}
" {{{2 by mhinz - Marco Hinz
" }}}2

" {{{1 Window display utilities
Plug 'halostatue/vim-zoom-win'
Plug 'itchyny/vim-cursorword'
Plug 'mhinz/vim-startify'
Plug 'myusuf3/numbers.vim'
" }}}1

" {{{1 Language/Syntax
" {{{2 API Definitions
Plug 'kylef/apiblueprint.vim', { 'for': 'apiblueprint' }
Plug 'IN3D/vim-raml', { 'for': 'raml' }
" }}}2
" {{{2 Ansible
Plug 'pearofducks/ansible-vim', { 'for': [ 'ansible', 'ansible_host', 'ansible_template'] }
" }}}2
" {{{2 Crystal
Plug 'rhysd/vim-crystal', { 'for': 'crystal' }
" }}}2
" {{{2 Elixir
Plug 'elixir-lang/vim-elixir', { 'for': [ 'elixir', 'eelixir' ] }
Plug 'mattreduce/vim-mix', { 'for': [ 'elixir', 'eelixir' ] }
Plug 'c-brenn/phoenix.vim'
Plug 'slashmili/alchemist.vim'
  " let g:alchemist_tag_disable = 1
" }}}2
" {{{2 Elm
Plug 'lambdatoast/elm.vim', { 'for': 'elm' }
" }}}2
" {{{2 Erlang
Plug 'vim-erlang/vim-erlang-runtime', { 'for': 'erlang' }
Plug 'vim-erlang/erlang-motions.vim', { 'for': 'erlang' }
Plug 'vim-erlang/vim-erlang-compiler'
Plug 'vim-erlang/vim-erlang-omnicomplete', { 'for': 'erlang' }
Plug 'vim-erlang/vim-erlang-tags', { 'for': 'erlang' }
" }}}2
" {{{2 Git, diff, etc.
Plug 'tpope/vim-git', { 'for': [ 'gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail', 'git' ] }
Plug 'lambdalisue/vim-unified-diff'
" }}}2
" {{{2 Go
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }
Plug 'vim-jp/vim-go-extra', { 'for': 'go', 'on': [ 'Godoc', 'Fmt', 'Import' ] }
Plug 'rhysd/vim-goyacc', { 'for': 'goyacc' }
" }}}2
" {{{2 HTML, CSS, SASS, SCSS, and Less
Plug 'groenewege/vim-less', { 'for': 'less' }
Plug 'othree/html5.vim'
Plug 'tpope/vim-haml', { 'for': [ 'haml', 'sass', 'scss' ] }
Plug 'JulesWang/css.vim', { 'for': [ 'css', 'scss', 'html' ] }
Plug 'hail2u/vim-css3-syntax', { 'for': [ 'css', 'scss', 'html' ] }
Plug 'rstacruz/vim-hyperstyle', { 'for': [ 'css', 'scss' ] }
Plug 'wavded/vim-stylus', { 'for': 'stylus' }
" }}}
" {{{2 Io
Plug 'andreimaxim/vim-io', { 'for': 'io' }
" }}}2
" {{{2 JavaScript
Plug 'glanotte/vim-jasmine', { 'for': 'jasmine.javascript' }
Plug 'mxw/vim-jsx', { 'for': 'javascript.jsx' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'posva/vim-vue', { 'for': [ 'vue', 'javascript.vue' ] }
Plug 'rhysd/npm-filetypes.vim', { 'for': [ 'npm-debug-log', 'npmrc' ]}

if hz#is#plugged('syntastic')
  Plug 'pmsorhaindo/syntastic-local-eslint.vim'
endif
" }}}2
" {{{2 JSON
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'vito-c/jq.vim', { 'for': 'jq' }
" }}}2
" {{{2 LaTeX / TeX
Plug 'lervag/vimtex', { 'for': [ 'tex', 'latex' ] }
" }}}2
" {{{2 Lua
Plug 'tbastos/vim-lua', { 'for': 'lua' }
" }}}2
" {{{2 Nim
Plug 'zah/nim.vim', { 'for': 'nim' }
" }}}2
" {{{2 Perl
Plug 'vim-perl/vim-perl', { 'for': 'perl' }
" }}}2
" {{{2 Postgres SQL/PgPLSQL
Plug 'exu/pgsql.vim', { 'for': 'pgsql' }
" }}}2
" {{{2 Python
Plug 'mitsuhiko/vim-python-combined', { 'for': 'python' }
Plug 'aliev/vim-compiler-python'
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }
" }}}2
" {{{2 Ruby
Plug 'vim-ruby/vim-ruby', { 'for': [ 'ruby', 'eruby' ] }
Plug 'depuracao/vim-rdoc', { 'for': 'ruby' }
Plug 'sunaku/vim-ruby-minitest', { 'for': 'ruby' }
Plug 'tpope/vim-bundler', { 'on': 'Bundle' }
Plug 'tpope/vim-rails', { 'on': 'Rails' }
Plug 'tpope/vim-rake', { 'on': 'Rake' }
Plug 'michaelbruce/vim-chruby'
" {{{3 Rspec
Plug 'sheerun/rspec.vim', { 'for': [ 'rspec', 'ruby.rspec' ] }
" }}}3
" {{{3 Tomdoc
Plug 'wellbredgrapefruit/tomdoc.vim', { 'for': 'tomdoc' }
" }}}3
" {{{3 Yard
Plug 'sheerun/vim-yardoc', { 'for': 'yard' }
" }}}3
" }}}2
" {{{2 Rust
Plug 'racer-rust/vim-racer', { 'for': 'rust' }
Plug 'rhysd/rust-doc.vim', { 'for': 'rust' }
Plug 'rhysd/vim-rustpeg', { 'for': 'rustpeg' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
" }}}2
" {{{2 Text files and markdown languages
Plug 'junegunn/goyo.vim' | Plug 'junegunn/limelight.vim'
Plug 'christoomey/vim-quicklink'
" {{{3 Markdown
" Disabled for issue https://github.com/plasticboy/vim-markdown/issues/323
" Plug 'plasticboy/vim-markdown'
Plug 'rhysd/vim-gfm-syntax', { 'for': 'markdown' }
" }}}3
" {{{3 Org
Plug 'jceb/vim-orgmode', { 'for': 'org' }
" }}}3
" {{{3 TaskPaper
Plug 'davidoc/taskpaper.vim', { 'for': 'taskpaper' }
" }}}3
" {{{3 Textile
Plug 'timcharper/textile.vim', { 'for': 'textile' }
" }}}3
" {{{3 Vimwiki
Plug 'vimwiki/vimwiki', { 'for': 'vimwiki' }
" }}}3
" }}}2
" {{{2 Templating languages
" {{{3 Jinja/Jinja2
" Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'mitsuhiko/vim-jinja'
" }}}3
" {{{3 JST
Plug 'briancollins/vim-jst', { 'for': 'jst' }
" }}}3
" {{{3 Liquid
Plug 'tpope/vim-liquid', { 'for': 'liquid' }
" }}}3
" {{{3 Mustache/Handlebars
Plug 'mustache/vim-mustache-handlebars', { 'for': [ 'html.mustache', 'html.handlebars' ] }
" }}}3
" {{{3 Pug (formerly Jade)
Plug 'digitaltoad/vim-pug', { 'for': 'pug' }
" }}}3
" {{{3 Slim
Plug 'slim-template/vim-slim', { 'for': 'slim' }
" }}}3
" }}}2
" {{{2 Toml
Plug 'cespare/vim-toml', { 'for': 'toml' }
" }}}2
" {{{2 Typescript
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
" }}}2
" {{{2 VimL/vimhelp
Plug 'junegunn/vader.vim', { 'for': 'vader', 'on': 'Vader' }
Plug 'tweekmonster/helpful.vim', { 'for': 'help' }
" {{{3 Folds
Plug 'thinca/vim-ft-diff_fold', { 'for': 'diff' }
Plug 'thinca/vim-ft-help_fold', { 'for': 'help' }
Plug 'thinca/vim-ft-vim_fold', { 'for' : 'vim' }
" }}}3
" }}}2
" {{{2 XML
Plug 'sukima/xmledit', { 'for': 'xml' }
Plug 'vim-scripts/XSLT-syntax', { 'for': [ 'xsl', 'xslt' ] }
" }}}2
" {{{2 YAML
Plug 'stephpy/vim-yaml', { 'for': 'yaml' }
" }}}2
" {{{2 GraphQL
Plug 'jparise/vim-graphql', { 'for': 'graphql' }
" }}}2
" }}}1

" {{{1 Color Schemes
Plug 'flazz/vim-colorschemes'
Plug 'godlygeek/csapprox'
Plug 'dracula/vim'
Plug 'chrisbra/Colorizer'
" }}}1

delfunction Cond

call plug#end()
" vim: foldmethod=marker
