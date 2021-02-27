call plug#begin('~/.local/share/nvim/plugged')
" Color scheme
Plug 'altercation/solarized'

" Status line
Plug 'bling/vim-airline'

" Project Navigation
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'easymotion/vim-easymotion'

Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'qpkorr/vim-bufkill'
Plug 'tpope/vim-surround'
Plug 'raimondi/delimitMate'
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'

" Language tooling
"Plug 'autozimu/LanguageClient-neovim', {
    "\ 'commit': 'ae23813',
    ""\ 'tag': 'v0.1.148',
    ""\ 'branch': 'next',
    "\ 'do': 'bash install.sh',
    "\ }
Plug 'neovim/nvim-lsp'

" Language Syntax
"Plug 'dense-analysis/ale', { 'tag': 'v2.4.1' }
Plug 'dense-analysis/ale', { 'tag': 'v2.6.0' }
Plug 'alvan/vim-closetag'

" Language Autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/deoplete-lsp'
" Disable jedi in favor of lsp
"Plug 'zchee/deoplete-jedi'

" Javascript
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'

" Typescript
Plug 'ianks/vim-tsx'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" Jsonnet
Plug 'google/vim-jsonnet'

" Nginx
Plug 'chr4/nginx.vim'

" Toml
Plug 'cespare/vim-toml'

" Python
Plug 'vim-python/python-syntax'

call plug#end()

" Color scheme
set background=dark
colorscheme solarized

set nowrap

" General
set mouse=a "use mouse everywhere
set relativenumber  "turn on line numbers
set ruler   "Always show current positions along the bottom
set showcmd "show the command being typed
set encoding=utf-8
set autoindent
set smartindent
set cindent cinkeys-=0# " Prevent python comments from breaking indent
filetype indent off

" Searching
set ignorecase
set smartcase
set hlsearch
set incsearch

" Save and Quit maps
" Got tired of accidentally hitting :Q and vim yelling at me
:command! W w
:command! Q q

" Tab mappings
nmap <tab> >>
nmap <S-tab> <<
vmap <tab> >
vmap <S-tab> <

" Make searching with asterisk keep cursor and screen in same position
nnoremap <silent> * :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

" Bane of my existence, stop those damn "This file is being edited" errors
set noswapfile

" Allow switching away from unsaved buffers
set hidden

" Persistent undo
set undofile
set undodir=$HOME/.config/nvim/undo
set undolevels=1000
set undoreload=10000

" Support local configs
set exrc
set secure

" Set correct paths for python binary
let g:python_host_prog = $HOME."/.pyenv/shims/python"
let g:python3_host_prog = $HOME."/.pyenv/shims/python"


" ==========================
" ---------MAPPINGS---------
" ==========================

" Let <ESC> enter normal mode in terminal mode
:tnoremap <Esc> <C-\><C-n>

" Use CTRL-hjkl to move around windows
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-l> :wincmd l<CR>

" Movement Mappings
nnoremap j gj
nnoremap k gk

vnoremap j gj
vnoremap k gk

" Break line at cursor
nnoremap K i<CR><Esc>
" Switch to last file
nmap <C-e> :e#<CR>

" Tabs
set tabstop=4
set shiftwidth=4
set expandtab
set list listchars=tab:»·,trail:·

" Paste Mappings
nnoremap <Leader>y "+y
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>y "+y
vnoremap <Leader>p "+p
vnoremap <Leader>P "+P

nnoremap <Leader>m :messages<CR>

" Change tab width depending on type (e.g. 4 for python, 2 for ruby)
autocmd FileType ruby,htmldjango.html,mustache.html,html.handlebars,html,yaml,jsonnet setlocal shiftwidth=2 tabstop=2
autocmd FileType python setlocal shiftwidth=4 tabstop=4
autocmd FileType json,proto setlocal shiftwidth=2 tabstop=2
autocmd FileType pug setlocal shiftwidth=2 tabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd FileType javascript.jsx setlocal shiftwidth=2 tabstop=2
autocmd FileType typescript.tsx setlocal shiftwidth=2 tabstop=2
autocmd FileType typescriptreact setlocal shiftwidth=2 tabstop=2
autocmd FileType typescript setlocal shiftwidth=2 tabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2
autocmd FileType sass,less setlocal shiftwidth=2 tabstop=2
autocmd FileType salt setlocal shiftwidth=2 tabstop=2
autocmd FileType tsv setlocal noexpandtab shiftwidth=20 tabstop=20  " Disable tab-to-spaces for tsv's

" typescriptreact type is no bueno with plugins (especially LanguageClient)
autocmd BufRead,BufNewFile *.tsx set filetype=typescript.tsx
autocmd BufRead,BufNewFile *.jsx set filetype=javascript.jsx

" Fold settings
set foldmethod=syntax
set foldlevelstart=99
autocmd FileType yml setlocal foldmethod=indent

" Like bufdo but restore the current buffer and refresh ctrl-p.
function! BufDo(command)
  let currBuff=bufnr("%")
  execute 'bufdo ' . a:command
  execute 'buffer ' . currBuff
  " Refresh ctrl p
  execute 'CtrlPClearCache'
endfunction
com! -nargs=+ -complete=command Bufdo call BufDo(<q-args>)
" Shortcut for refreshing vim
nnoremap <Leader>R :Bufdo all<CR>

" Debugging shortcuts
autocmd FileType javascript.jsx,typescript,typescript.tsx nnoremap <buffer> <Leader>br Odebugger<ESC>
autocmd FileType python nnoremap <buffer> <Leader>br Oimport ipdb; ipdb.set_trace()<ESC>

" ==========================
" -----------LSP------------
" ==========================
lua << EOF
    local nvim_lsp = require'nvim_lsp'
    nvim_lsp.tsserver.setup{}
    -- Uncomment to switch python language sever impls
    -- nvim_lsp.pyls_ms.setup{} -- Requires :LspInstall pyls_ms
    nvim_lsp.pyls.setup{} -- Requires pip install python-language-server
    nvim_lsp.rls.setup{}

    -- Disable Inline Diagnostics globally
    vim.lsp.callbacks["textDocument/publishDiagnostics"] = function() end
EOF

" ==========================
" ---------PLUGINS----------
" ==========================
" ~~~LSP~~~
nnoremap <Leader>D  <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <Leader>d  <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <Leader>s  <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <Leader>r  <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap gD         <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap gk         <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <Leader>S  <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap gr         <cmd>lua vim.lsp.buf.references()<CR>
nnoremap g0         <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap gW         <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

" ~~~ Ack ~~~
" By default, don't open first result in buffer
ca Ack Ack!
" Ack for the currently highlighted text
nnoremap <Leader>a :Ack! 
xnoremap <Leader>a y:Ack! <C-r>=fnameescape(@")<CR><CR>

" ~~~~~ Ctrl-P ~~~~~
nnoremap <silent> <Leader>t :CtrlP<CR>
nnoremap <silent> <Leader>T :CtrlPBuffer<CR>
"nnoremap ; :CtrlPBuffer<CR>
let g:ctrlp_custom_ignore = {
  \ 'dir': 'public\/static$|node_modules$|\.git$|build$|dist$|\.venv$|\.mypy_cache$',
  \ 'file': '\.pyc$'
  \ } " OLD VALUE: '\.(pyc)|public/static/*$|node_modules/*|\.git/*|build/*|dist/*|\.venv/*$|\.mypy_cache/*$'
let g:ctrlp_working_path_mode = 0 " Only search in directory that vim started off in (important for monorepos, otherwise it crawls up the tree and searches the entire repo)
let g:ctrlp_show_hidden = 1
set wildignore+=*.pyc
set wildignore+=*/.git/*
set wildignore+=*/node_modules/*
set wildignore+=*/.venv/*
set wildignore+=*/.mypy_cache/*

" ~~~~~ Vim-Fugitive ~~~~~
set diffopt+=vertical " make diffs open vertically instead of horizontally (ew)

" ~~~~~ UltiSnips ~~~~~
let g:UltiSnipsExpandTrigger="<leader>*"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsSnippetDirectories = ['UltiSnips', $HOME.'/.config/UltiSnips']

" ~~~~~ NERDTree ~~~~~
nnoremap <silent> <Leader>nt :NERDTree<CR>
nnoremap <Leader>e :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$'] " ignore certain file extensions

" ~~~~~ Vim-Airline ~~~~~
let g:airline_section_z = '%l/%L'
let g:airline_section_y = '%Y'
let g:airline_section_x = ''
let g:airline_left_sep=''
let g:airline_right_sep=''

" ~~~~~ ALE ~~~~~
" Temporary fix since tslint doesn't respect the local prettierrc. Use global
" tsserver instead
let g:ale_linters = {'typescript': ['tsserver', 'eslint'], 'javascript': ['eslint']}
nnoremap <Leader>f :ALEFix<CR>

" Fixer for jsonnet files
autocmd FileType jsonnet nnoremap <buffer> <Leader>f :w<CR>:silent !jsonnetfmt --comment-style s --string-style d -i %<CR>

" Specify fixers for different filetypes
let g:ale_fixers = {
    \ 'svg': ['xmllint'],
    \ 'python': ['black', 'isort'],
    \ 'javascript': ['eslint', 'prettier'],
    \ 'typescript': ['eslint', 'prettier'],
    \ }
"autocmd FileType javascript,javascript.jsx,typescript,typescript.tsx,typescriptreact let b:ale_fixers = ['eslint']

" Set MYPYPATH explicitly if we're in a virtualenv
"if !empty($VIRTUAL_ENV)
    "let $MYPYPATH = $VIRTUAL_ENV.''
"else
"endif

" ~~~~~ Deoplete ~~~~~
let g:deoplete#enable_at_startup = 1
" Tabs for scrolling
inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<tab>"
inoremap <expr><C-n> deoplete#mappings#manual_complete()
set completeopt=menu,noinsert,menuone

" ~~~~~ python-syntax ~~~~~
let g:python_highlight_all = 1

" ~~~~~ nvim-typescript ~~~~~
"autocmd FileType typescript,typescript.tsx nmap <buffer> <Leader>d :TSDef<CR>
"autocmd FileType typescript,typescript.tsx nnoremap <buffer> <Leader>D :TSDefPreview<CR>
"autocmd FileType typescript,typescript.tsx nmap <buffer> <Leader>r :TSRename<CR>
"autocmd FileType typescript,typescript.tsx nmap <buffer> <Leader>s :TSType<CR>
"autocmd FileType typescript,typescript.tsx nnoremap <buffer> <Leader>S :TSTypeDef<CR>

" ~~~~~ LanguageClient-neovim ~~~~~
"" How to start language servers
"let g:LanguageClient_serverCommands = {
    "\ 'typescriptreact': ['typescript-language-server', '--stdio'],
    "\ 'typescript.tsx': ['typescript-language-server', '--stdio'],
    "\ 'typescript': ['typescript-language-server', '--stdio'],
    "\ 'javascript.jsx': ['typescript-language-server', '--stdio'],
    "\ 'python': ['pyls', '-v'],
    "\ 'rust': ['rls'],
    "\ }
"" Requires neovim 0.4.0 dev build
"let g:LanguageClient_useFloatingHover = 1
"" Don't need virtual text, we have ALE for linting
"let g:LanguageClient_useVirtualText = 0
"" Disable diagnostics, they end up wiping the ctrl-p pane
"let g:LanguageClient_diagnosticsEnable = 0
"nnoremap <Leader>d :call LanguageClient#textDocument_definition()<CR>
"nnoremap <Leader>D :call LanguageClient#textDocument_definition({'gotoCmd': 'split'})<CR>
"nnoremap <Leader>c :call LanguageClient#textDocument_rename()<CR>
"nnoremap <Leader>r :call LanguageClient#textDocument_references()<CR>
"nnoremap <Leader>s :call LanguageClient#textDocument_hover()<CR>
"nnoremap <Leader>S :call LanguageClient#textDocument_typeDefinition()<CR>

" ~~~~~ Closetag ~~~~~
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.tsx,*.jsx,*.js'
let g:closetag_regions = {
    \ 'typescriptreact': 'jsxRegion,tsxRegion',
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ 'javascript': 'jsxRegion',
    \ }

" ~~~~~ Delimitmate ~~~~~
" Prevent conflict with closetag (adding extra ending bracket '>')
au FileType xml,html,phtml,php,xhtml,js,jsx,ts,tsx let b:delimitMate_matchpairs = "(:),[:],{:}"

" ~~~~~ jsonnet ~~~~~
let g:jsonnet_fmt_on_save = 0

" ===============================================
" ---------DIRECTORY-SPECIFIC-SETTINGS-----------
" ===============================================
" ~~~~~~~~~~~~~~~~~ZENTREEFISH~~~~~~~~~~~~~~~~~~~
let ZTF_LINT_PATH = '~/kensho/zentreefish/klib/pkgs/kensho_lint/kensho_lint/setup.cfg'
let ZTF_PYLINT_PATH = '~/kensho/zentreefish/klib/pkgs/kensho_lint/kensho_lint/.pylintrc'
let ZTF_TOML_PATH = '~/kensho/zentreefish/klib/pkgs/kensho_lint/kensho_lint/pyproject.toml'
autocmd BufRead,BufNewFile */kensho/zentreefish/* let g:ale_python_black_options = '--config ' . ZTF_TOML_PATH
autocmd BufRead,BufNewFile */kensho/zentreefish/* let g:ale_python_flake8_options = '--config ' . ZTF_LINT_PATH
autocmd BufRead,BufNewFile */kensho/zentreefish/* let g:ale_python_isort_options = '--settings-path ' . ZTF_LINT_PATH
autocmd BufRead,BufNewFile */kensho/zentreefish/* let g:ale_python_pylint_options = '--rcfile ' . ZTF_PYLINT_PATH
autocmd BufRead,BufNewFile */kensho/zentreefish/* let g:ale_python_mypy_options = '--config-file ' . ZTF_LINT_PATH
