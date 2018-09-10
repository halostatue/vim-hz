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
Plug 'tpope/vim-apathy'
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
Plug 'junegunn/vim-fnr'
" }}}2

" {{{2 by kana - Kana Natsuno
Plug 'kana/vim-smartchr'
Plug 'kana/vim-smartinput'
" }}}2

" {{{2 by lambdalisue
Plug 'lambdalisue/vim-foldround'
" }}}2

" {{{2 by Shougo
Plug 'Shougo/context_filetype.vim'
Plug 'Shougo/echodoc.vim'
" }}}

" {{{2 by thinca
Plug 'thinca/vim-localrc'
" }}}

" {{{2 by tomtom - Tom Link
Plug 'tomtom/tinykeymap_vim'
" }}}2

" {{{2 by romainl - Romain Lafourcade
Plug 'romainl/vim-qf'
Plug 'romainl/vim-qlist'
" }}}

" {{{2 Other
Plug 'sgur/vim-editorconfig'
Plug 'direnv/direnv.vim'
Plug 'chrisbra/unicode.vim'
Plug 'vim-utils/vim-troll-stopper'
Plug 'unblevable/quick-scope'
Plug 'machakann/vim-swap'
" }}}2
" }}}1

" {{{1 Project-related tools
" {{{2 Fuzzy Finders
" {{{3 fzf
if homebrew#isdirectory('opt/fzf')
  let &runtimepath .= ',' . homebrew#path('opt/fzf')
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
endif
Plug 'runfalk/vim-fzf-extended'
" }}}3

" {{{3 LeaderF: A new favourite
Plug 'yggdroot/leaderf', { 'do': './install.sh' }
Plug 'yggdroot/leaderf-marks'
Plug 'xltan/leaderf-tjump'
Plug 'youran0715/leaderf-cmdpalette'
Plug 'youran0715/leaderf-goimport'
Plug 'bennyyip/leaderf-github-stars'
Plug 'bstaint/leaderf-grep'
" }}}3
" }}}2

" {{{2 NERDTree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'AndrewRadev/andrews_nerdtree.vim'
Plug 'chuckfairy/nerdtree-reveal'
Plug 'Nopik/vim-nerdtree-direnter'
Plug 'evandotpro/nerdtree-chmod'
Plug 'rargo/vim-line-jump'
Plug 'gabenespoli/vim-cider-vinegar'
Plug 'jeetsukumaran/vim-buffergator'
" }}}2
Plug 'majutsushi/tagbar'
Plug 'justinmk/vim-gtfo'
Plug 'tyru/open-browser.vim'
" }}}2
" }}}1

" {{{1 Version Control
" {{{2 Git: Fugitive
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim', { 'on': 'GV' }
Plug 'gregsexton/gitv', { 'on': 'Gitv' }
Plug 'lambdalisue/gina.vim', { 'on': 'Gina' }
Plug 'rhysd/committia.vim'
" }}}2

" {{{2 Mercurial
Plug 'jlfwong/vim-mercenary'
" }}}2
" }}}1

" {{{1 Window display utilities
Plug 'halostatue/vim-zoom-win'
Plug 'itchyny/vim-cursorword'
Plug 'mhinz/vim-startify'
Plug 'myusuf3/numbers.vim'
" Plug 'tpope/vim-flagship'
" }}}1

" {{{1 Text objects
Plug 'junegunn/vim-after-object'
Plug 'vim-utils/vim-all'
Plug 'vim-utils/vim-line'
Plug 'vim-utils/vim-space'
Plug 'wellle/targets.vim'
Plug 'michaeljsmith/vim-indent-object'

" {{{2 Provided by kana/vim-textobj-user
"      Temporarily disabled for performance investigation.
" Plug 'kana/vim-textobj-user'
"
" Plug 'bootleq/vim-textobj-rubysymbol'
" Plug 'kana/vim-textobj-datetime'
" Plug 'kana/vim-textobj-diff'
" Plug 'kana/vim-textobj-fold'
" Plug 'kana/vim-textobj-function'
" Plug 'thinca/vim-textobj-function-javascript'
" Plug 'thinca/vim-textobj-function-perl'
" Plug 'kana/vim-textobj-indent'
" Plug 'kana/vim-textobj-line'
" Plug 'kana/vim-textobj-syntax'
" Plug 'lucapette/vim-textobj-underscore'
" Plug 'nelstrom/vim-textobj-rubyblock'
" Plug 'reedes/vim-textobj-quote'
" Plug 'reedes/vim-textobj-sentence'
" Plug 'rhysd/vim-textobj-anyblock'
" Plug 'rhysd/vim-textobj-ruby'
" Plug 'rhysd/vim-textobj-conflict'
" Plug 'thalesmello/vim-textobj-methodcall'
" Plug 'thinca/vim-textobj-comment'
" Plug 'whatyouhide/vim-textobj-xmlattr'
" }}}2
" }}}1

" {{{1 Language/Syntax
" {{{2 API Definitions
Plug 'kylef/apiblueprint.vim', { 'for': 'apiblueprint' }
Plug 'IN3D/vim-raml', { 'for': 'raml' }
" }}}2

" {{{2 Alternative Shells
Plug 'dmix/elvish.vim', { 'for': 'elvish' }
Plug 'dag/vim-fish', { 'for': 'fish' }
" }}}2

" {{{2 Ansible
Plug 'pearofducks/ansible-vim', { 'for': [ 'ansible', 'ansible_host', 'ansible_template'] }
Plug 'b4b4r07/vim-ansible-vault'
" }}}2

" {{{2 AppleScript
Plug 'vim-scripts/applescript.vim', { 'for': 'applescript' }
" }}}2

" {{{2 C/C++
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': [ 'cpp' ] }
Plug 'vim-jp/vim-cpp', { 'for': [ 'c', 'cpp' ] }
Plug 'lyuts/vim-rtags', { 'for': [ 'c', 'cpp' ] }
" {{{3 YACC Output y.output
Plug 'rhysd/y-output.vim', { 'for': 'y-output' }
" }}}3
" }}}2

" {{{2 Clojure
Plug 'kovisoft/paredit', { 'for': 'clojure' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
Plug 'guns/vim-clojure-highlight', { 'for': 'clojure' }
Plug 'tpope/vim-salve', { 'for': 'clojure' }
Plug 'guns/vim-sexp', { 'for': [ 'clojure', 'scheme', 'lisp' ] }
Plug 'guns/vim-slamhound', { 'on': 'Slamhound' }
Plug 'tpope/vim-classpath', { 'for': [ 'clojure', 'java' ], 'on': [ 'Java' ] }
Plug 'venantius/vim-cljfmt', { 'on': [ 'Cljfmt', 'CljfmtRange', 'CljfmtRequire' ] }
" }}}2

" {{{2 Coffeescript
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
Plug 'mtscout6/vim-cjsx', { 'for': 'coffee' }
" }}}2

" " {{{2 Configuration Files
" " {{{3 LogStash
" Plug 'robbles/logstash.vim', { 'for': 'logstash' }
" " }}}3
" " {{{3 Nginx
" Plug 'othree/nginx-contrib-vim', { 'for': 'nginx' }
" " }}}3
" " {{{3 Systemd
" Plug 'kurayama/systemd-vim-syntax', { 'for': 'systemd' }
" " }}}3
" " }}}2

" {{{2 CQL
Plug 'elubow/cql-vim', { 'for': 'cql' }
" }}}2

" {{{2 Cryptol
Plug 'victoredwardocallaghan/cryptol.vim', { 'for': 'cryptol' }
" }}}2

" {{{2 Crystal
Plug 'rhysd/vim-crystal', { 'for': 'crystal' }
" }}}2

" {{{2 CSV
Plug 'chrisbra/csv.vim', { 'for': 'csv' }
" }}}2

" {{{2 Cucumber
Plug 'tpope/vim-cucumber', { 'for': 'cucumber' }
" }}}2

" {{{2 Dart
Plug 'dart-lang/dart-vim-plugin', { 'for': 'dart' }
" }}}2

" {{{2 Data description languages (thrift, avro, protobuf)
Plug 'solarnz/thrift.vim', { 'for': 'thrift' }
Plug 'uarun/vim-protobuf', { 'for': 'proto' }
" }}}2

" {{{2 Docker
Plug 'honza/dockerfile.vim', { 'for': 'dockerfile' }
" Plug 'ekalinin/Dockerfile.vim'
" }}}2

" {{{2 Ember
Plug 'yalesov/vim-ember-script', { 'for': 'ember-script' }
Plug 'yalesov/vim-emblem', { 'for': 'emblem' }
" }}}2

" {{{2 Elixir
Plug 'elixir-lang/vim-elixir', { 'for': [ 'elixir', 'eelixir' ] }
Plug 'mhinz/vim-mix-format', { 'for': [ 'elixir', 'eelixir' ] }
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
Plug 'tpope/vim-git'
Plug 'lambdalisue/vim-unified-diff'
" }}}2

" {{{2 GLSL
Plug 'tikhomirov/vim-glsl', { 'for': 'glsl' }
" }}}2

" {{{2 Go
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }
Plug 'vim-jp/vim-go-extra', { 'for': 'go', 'on': [ 'Godoc', 'Fmt', 'Import' ] }
Plug 'rhysd/vim-goyacc', { 'for': 'goyacc' }
" }}}2

" {{{2 GraphQL
Plug 'jparise/vim-graphql', { 'for': 'graphql' }
" }}}2

" {{{2 Groovy
Plug 'vim-scripts/groovy.vim', { 'for': 'groovy' }
" }}}2

" {{{2 Haskell
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
" }}}2

" {{{2 Haxe
Plug 'yaymukund/vim-haxe', { 'for': 'haxe' }
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
" }}}2

" {{{2 JSON
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'vito-c/jq.vim', { 'for': 'jq' }
" }}}2

" {{{2 Julia
Plug 'dcjones/julia-minimalist-vim', { 'for': 'julia' }
" }}}2

" {{{2 Kotlin
Plug 'udalov/kotlin-vim', { 'for': 'kotlin' }
" }}}2

" {{{2 LaTeX / TeX
Plug 'lervag/vimtex', { 'for': [ 'tex', 'latex' ] }
" }}}2

" {{{2 LiveScript
Plug 'gkz/vim-ls', { 'for': 'livescript' }
" }}}2

" {{{2 Lua
Plug 'tbastos/vim-lua', { 'for': 'lua' }
" }}}2

" {{{2 Mako
Plug 'sophacles/vim-bundle-mako', { 'for': 'mako' }
" }}}2

" {{{2 Nim
Plug 'zah/nim.vim', { 'for': 'nim' }
" }}}2

" {{{2 Nix
Plug 'spwhitt/vim-nix', { 'for': 'nix' }
" }}}2

" {{{2 Objective-C
Plug 'b4winckler/vim-objc', { 'for': 'objc' }
Plug 'msanders/cocoa.vim', { 'for': 'objc' }
" }}}2

" {{{2 Ocaml/Reason
Plug 'jrk/vim-ocaml', { 'for': 'ocaml' }
Plug 'reasonml-editor/vim-reason'
" }}}2

" {{{2 Octave
Plug 'vim-scripts/octave.vim--', { 'for': 'octave' }
" }}}2

" {{{2 OpenCL
Plug 'petRUShka/vim-opencl', { 'for': 'opencl' }
" }}}2

" {{{2 Perl
Plug 'vim-perl/vim-perl', { 'for': 'perl' }
" }}}2

" {{{2 PHP
Plug 'StanAngeloff/php.vim', { 'for': 'php' }
Plug 'rayburgemeestre/phpfolding.vim', { 'for': 'php' }
Plug 'shawncplus/phpcomplete.vim', { 'for': 'php' }
Plug '2072/PHP-Indenting-for-VIm', { 'for': 'php' }
Plug 'rafi/vim-phpspec', { 'for': 'php' }
" }}}2

" {{{2 Postgres SQL/PgPLSQL
Plug 'exu/pgsql.vim', { 'for': 'pgsql' }
" }}}2

" {{{2 PlantUML
Plug 'aklt/plantuml-syntax', { 'for': 'plantuml' }
" }}}2

" {{{2 PowerShell
Plug 'PProvost/vim-ps1', { 'for': [ 'ps1', 'ps1xml' ] }
" }}}2

" {{{2 Puppet
Plug 'voxpupuli/vim-puppet', { 'for': [ 'puppet', 'ruby' ] }
Plug 'ajf/puppet-vim', { 'for': 'puppet' }
" }}}2

" {{{2 PureScript
Plug 'raichoo/purescript-vim', { 'for': 'purescript' }
" }}}2

" {{{2 Python
Plug 'mitsuhiko/vim-python-combined', { 'for': 'python' }
Plug 'aliev/vim-compiler-python'
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }
" }}}2

" {{{2 QML
Plug 'peterhoeg/vim-qml', { 'for': 'qml' }
" }}}2

" {{{2 R
Plug 'vim-scripts/R.vim', { 'for': 'r-lang' }
" }}}2

" {{{2 Ragel
Plug 'jneen/ragel.vim', { 'for': 'ragel' }
" }}}2

" {{{2 Ruby
Plug 'vim-ruby/vim-ruby', { 'for': [ 'ruby', 'eruby' ] }
Plug 'depuracao/vim-rdoc', { 'for': 'ruby' }
Plug 'sunaku/vim-ruby-minitest', { 'for': 'ruby' }
Plug 'tpope/vim-bundler', { 'for': 'ruby' }
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
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

" {{{2 Scala
Plug 'derekwyatt/vim-scala', { 'for': 'scala' }
Plug 'derekwyatt/vim-sbt', { 'for': 'sbt.scala' }
" Plug 'ensime/ensime-vim',    { 'for': 'scala' }
" }}}2

" {{{2 Solidity
Plug 'ethereum/vim-solidity', { 'for': 'solidity' }
" }}}2

" {{{2 Swift
Plug 'keith/swift.vim', { 'for': 'swift' }
" }}}2

" {{{2 Text files and markdown languages
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'christoomey/vim-quicklink'
Plug 'godlygeek/tabular'

" {{{3 Markdown
" Disabled for issue https://github.com/plasticboy/vim-markdown/issues/323
" Plug 'plasticboy/vim-markdown'
" Plug 'tpope/vim-markdown'
Plug 'rhysd/vim-gfm-syntax', { 'for': 'markdown' }
" }}}3

" {{{3 Org
Plug 'jceb/vim-orgmode', { 'for': 'org' }
" }}}3

" {{{3 Pandoc (including Markdown)
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
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
Plug 'Glench/Vim-Jinja2-Syntax'
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

" {{{2 tmux.conf
Plug 'tmux-plugins/vim-tmux', { 'for': 'tmux' }
Plug 'ericpruitt/tmux.vim', { 'for': 'tmux', 'rtp': 'vim/' }
" }}}2

" {{{2 Twig
Plug 'lumiliet/vim-twig', { 'for': 'twig' }
" }}}2

" {{{2 Typescript
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
" }}}2

" {{{2 Vala
Plug 'tkztmk/vim-vala', { 'for': 'vala' }
" }}}2

" {{{2 VB.net
Plug 'vim-scripts/vbnet.vim', { 'for': 'vbnet' }
" }}}2

" {{{2 VCL
Plug 'smerrill/vcl-vim-plugin', { 'for': 'vcl' }
" }}}2

" {{{2 Velocity
Plug 'lepture/vim-velocity', { 'for': 'velocity' }
" }}}2

" {{{2 VimL/vimhelp
Plug 'vim-jp/syntax-vim-ex'
Plug 'junegunn/vader.vim', { 'for': 'vader', 'on': 'Vader' }
Plug 'tweekmonster/helpful.vim', { 'for': 'help' }
Plug 'lambdalisue/vim-backslash'

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

" {{{2 WebAssembly
Plug 'rhysd/vim-wasm', { 'for': 'wast' }
" }}}2
" }}}1

" {{{1 Language Syntax checking and formatting
" Plug 'w0rp/ale'
Plug 'neomake/neomake'
Plug 'prabirshrestha/vim-lsp'
" plug 'sbdchd/neoformat'
" Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
" Plug 'maralla/validator.vim'
" }}}1

" {{{1 Completion, Snippets, and Tags
" {{{2 Snippets
" {{{3 Ultisnips
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" }}}3

" {{{3 Neosnippet
" Plug 'Shougo/neosnippet.vim'
" Plug 'Shougo/neosnippet-snippets'
" }}}3
" }}}2

" {{{2 Completion
Plug 'Shougo/neco-syntax'
Plug 'Shougo/neco-vim'

" {{{3 OmniComplete Sources
Plug 'vim-jp/vital-complete', { 'for': 'vim' }
" }}}3

" {{{3 maralla: Completor
" Plug 'maralla/completor.vim'
" Plug 'maralla/completor-swift', { 'do': 'make' }
" }}}3

" {{{3 prabirshrestha: asyncomplete
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete-buffer.vim'
Plug 'prabirshrestha/asyncomplete-emoji.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'
Plug 'prabirshrestha/asyncomplete-gocode.vim'
Plug 'prabirshrestha/asyncomplete-flow.vim'
Plug 'keremc/asyncomplete-racer.vim'
Plug 'prabirshrestha/asyncomplete-tags.vim'

if hz#is#plugged('ultisnips')
  Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
endif
if hz#is#plugged('neco-syntax')
  Plug 'prabirshrestha/asyncomplete-necosyntax.vim'
endif
if hz#is#plugged('neco-vim')
  Plug 'prabirshrestha/asyncomplete-necovim.vim'
endif
if hz#is#plugged('neosnippet.vim')
  Plug 'prabirshrestha/asyncomplete-neosnippet.vim'
endif
if hz#is#plugged('tscompletejob')
  " Plug 'runoshun/tscompletejob'
  Plug 'prabirshrestha/asyncomplete-tscompletejob.vim'
endif

" This is apparently buggy.
" Plug 'yami-beta/asyncomplete-omni.vim'
" }}}3
" }}}2


Plug 'ludovicchabant/vim-gutentags'
" Plug 'jsfaint/gen_tags.vim'

" }}}1

" {{{1 Color Schemes
Plug 'flazz/vim-colorschemes'
Plug 'godlygeek/csapprox'
Plug 'dracula/vim'
Plug 'chrisbra/Colorizer'
Plug 'yggdroot/duoduo'
Plug 'yuttie/hydrangea-vim'
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'AlessandroYorba/Despacio'
Plug 'nightsense/snow'
Plug 'nightsense/stellarized'
Plug 'arcticicestudio/nord-vim'
" }}}1

" {{{1 Motions
Plug 'christoomey/vim-sort-motion'
Plug 'christoomey/vim-system-copy'
Plug 'haya14busa/vim-asterisk'
Plug 'justinmk/vim-sneak'
Plug 'rhysd/clever-f.vim'
Plug 'vim-scripts/camelcasemotion'
" }}}1

" {{{1 :Commands
Plug 'Shougo/vinarise', { 'on': 'Vinarise' }
Plug 'Yggdroot/indentLine', { 'on': [ 'IndentLinesEnable', 'IndentLinesToggle' ] }
Plug 'abudden/taghighlight-automirror', { 'on': 'UpdateTypesFile' }
Plug 'ervandew/lookup', { 'on': 'Lookup' }
Plug 'janko-m/vim-test', { 'on': [ 'TestNearest', 'TestFile', 'TestSuite', 'TestLast', 'TestVisit' ] }
Plug 'jeetsukumaran/vim-buffergator', { 'on': [ 'BuffergatorToggle' ] }
Plug 'junegunn/vim-easy-align', { 'on': [ '<Plug>(EasyAlign)', 'EasyAlign' ] }
Plug 'junegunn/vim-github-dashboard', { 'on': ['GHDashboard', 'GHActivity'] }
" Plug 'justinmk/vim-dirvish', { 'on': 'Dirvish' }
Plug 'kana/vim-grex', { 'on': [ 'Grey', 'Gred' ] }
Plug 'lambdalisue/vim-gista', { 'on': 'Gista' }
Plug 'mattn/gist-vim', { 'on': 'Gist' }
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'mhinz/vim-grepper', { 'on': [ 'Grepper', '<Plug>(GrepperOperator)' ] }
Plug 'rhysd/vim-grammarous', { 'on': 'GrammarousCheck' }
Plug 'rstacruz/vim-xtract', { 'on': 'Xtract' }
Plug 'thinca/vim-editvar', { 'on': 'Editvar' }
Plug 'thinca/vim-github', { 'on': 'Github' }
Plug 'thinca/vim-qfreplace', { 'on': 'Qfreplace' }
Plug 'thinca/vim-ref', { 'on': 'Ref' }
Plug 'tomtom/autolinker_vim', { 'on': 'Albuffer' }
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-heroku', { 'on': [ 'Hk', 'Heroku' ] }
Plug 'vim-utils/vim-man', { 'on': [ 'Man', 'Vman', 'Mangrep' ] }

" {{{2 Mac Commands
if hz#is#mac()
  Plug 'itchyny/dictionary.vim', { 'on': 'Dictionary' }
  Plug 'rizzatti/dash.vim', { 'on': [ '<Plug>DashSearch', '<Plug>DashGlobalSearch', 'Dash' ] }
  Plug 'vim-scripts/ColorX', { 'on': [ 'ColorRGB', 'ColorHEX' ] }
endif
" }}}2

" {{{2 Windows Commands
if hz#is#windows()
  Plug 'thinca/vim-winenv', { 'on': 'WinEnv', '<Plug>(winenv-edit)' }
endif
" }}}2

" {{{3 Unix Commands
if !hz#is#windows()
  Plug 'lambdalisue/suda.vim'
endif
" }}}

" {{{2 QuickRun Plugins
Plug 'thinca/vim-quickrun', { 'on': [ 'QuickRun', '<Plug>(quickrun)' ] }
Plug 'bootleq/vim-qrpsqlpq'
Plug 'rhysd/quickrun-mac_notifier-outputter'
" }}}2
" }}}1

" {{{1 gf (open file under cursor) extensions
Plug 'kana/vim-gf-user'
Plug 'kana/vim-gf-diff', { 'for': 'diff' }
" }}}1

" {{{1 Operators
Plug 'kana/vim-niceblock'
Plug 'kana/vim-operator-user'
Plug 'kana/vim-operator-replace'
Plug 'tommcdo/vim-exchange'
Plug 'rhysd/vim-operator-trailingspace-killer'
" }}}1

" {{{1 Scratch buffer
" Plug 'kana/vim-scratch', { 'on': [ '<Plug>(scratch-open)', '<Plug>(scratch-close)' ] }
Plug 'thinca/vim-quickmemo'
" }}}1

" {{{1 Editing
Plug 'tomtom/tcomment_vim'
" Plug 'tpope/commentary'
" Plug 'scrooloose/nerdcommenter'
" Plug 'tyru/caw.vim'

Plug 'terryma/vim-multiple-cursors'
Plug 'landock/vim-expand-region'
Plug 'csexton/trailertrash.vim'

" {{{2 Signs
" Plug 'mhinz/vim-signify'
Plug 'tomtom/quickfixsigns_vim'
" }}}2
" }}}1

" {{{1 Window display utilities
Plug 'thinca/vim-fontzoom', { 'on': [ '<Plug>(fontzoom-larger)', '<Plug>(fontzoom-smaller)' ] }

" {{{2 Search
Plug 'haya14busa/is.vim'
Plug 'haya14busa/vim-asterisk'
Plug 'osyo-manga/vim-anzu'
Plug 'google/vim-searchindex'
" }}}2
" }}}1

" {{{1 Asynchronous Execution
Plug 'tpope/vim-dispatch'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
" Plug 'skywind3000/asyncrun.vim'
" }}}1

" {{{1 VimL (VimScript) Libraries
Plug 'junegunn/vim-emoji'
Plug 'junegunn/vim-ruby-x', { 'on': 'RubyX' }
Plug 'mattn/webapi-vim'
Plug 'tpope/vim-haystack'
Plug 'tpope/vim-scriptease'
Plug 'tomtom/tlib_vim'
Plug 'tweekmonster/exception.vim'
Plug 'mhinz/vim-lookup'
Plug 'tweekmonster/helpful.vim'
Plug 'thinca/vim-openbuf'
Plug 'kana/vim-submode'
Plug 'prabirshrestha/async.vim'
Plug 'vim-jp/vital.vim', { 'on': [ 'Vitalize' ] }
Plug 'lambdalisue/vital-Whisky'
Plug 'vim-jp/autofmt'
" }}}1

" {{{1 SQL Development utilities
Plug 'tpope/vim-dadbod', { 'on': [ 'DB' ] }
" Plug 'vim-scripts/dbext.vim'
" }}}1

" {{{1 tmux plug-ins
" These should be used with Tmux Plugin Manager:
"   set -g @plugin 'tmux-plugins/tpm'
"   set -g @plugin 'tmux-plugins/tmux-sensible'
"   set -g @plugin 'christoomey/vim-tmux-navigator'
"   run '~/.tmux/plugins/tpm/tpm'
Plug 'tmux-plugins/vim-tmux-focus-events', Cond(hz#is#tmux())
Plug 'christoomey/vim-tmux-navigator', Cond(hz#is#tmux())
Plug 'wellle/tmux-complete.vim', Cond(hz#is#tmux() && hz#is#plugged('asyncomplete.vim'))
Plug 'tpope/vim-tbone', Cond(hz#is#tmux())
" Plug 'junegunn/heytmux', Cond(hz#is#tmux())
" heytmux is like Tmuxinator, teamocil, and tmuxp
" }}}1

delfunction Cond

" Plug 'mhinz/vim-halo'

call plug#end()
" vim: foldmethod=marker
