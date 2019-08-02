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
Plug 'tpope/vim-surround'
Plug 'qpkorr/vim-bufkill'
Plug 'raimondi/delimitMate'
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'

" Language tooling
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" Language Syntax
Plug 'w0rp/ale'
Plug 'alvan/vim-closetag'

" Language Autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'zchee/deoplete-jedi'

" Javascript
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }

" Typescript
Plug 'ianks/vim-tsx'
Plug 'herringtondarkholme/yats.vim'

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

" Persistent undo
set undofile
set undodir=$HOME/.config/nvim/undo
set undolevels=1000
set undoreload=10000


" ==========================
" ---------MAPPINGS---------
" ==========================

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


" Change tab width depending on type (e.g. 4 for python, 2 for ruby)
autocmd FileType ruby,htmldjango.html,mustache.html,html.handlebars,html setlocal shiftwidth=2 tabstop=2
autocmd FileType python setlocal shiftwidth=4 tabstop=4
autocmd FileType json,proto setlocal shiftwidth=2 tabstop=2
autocmd FileType pug setlocal shiftwidth=2 tabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd FileType javascript.jsx setlocal shiftwidth=2 tabstop=2
autocmd FileType typescript.tsx setlocal shiftwidth=2 tabstop=2
autocmd FileType typescript setlocal shiftwidth=2 tabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2
autocmd FileType sass,less setlocal shiftwidth=2 tabstop=2
autocmd FileType salt setlocal shiftwidth=2 tabstop=2
autocmd FileType tsv setlocal noexpandtab shiftwidth=20 tabstop=20  " Disable tab-to-spaces for tsv's

" Fold settings
set foldmethod=syntax
set foldlevelstart=99

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
" ---------PLUGINS----------
" ==========================
" Ack
" By default, don't open first result in buffer
ca Ack Ack!
" Ack for the currently highlighted text
nnoremap <Leader>a :Ack! 
xnoremap <Leader>a y:Ack! <C-r>=fnameescape(@")<CR><CR>

" Ctrl-P 
nnoremap <silent> <Leader>t :CtrlP<CR>
nnoremap <silent> <Leader>T :CtrlPBuffer<CR>
"nnoremap ; :CtrlPBuffer<CR>
let g:ctrlp_custom_ignore = '\.(pyc)|public/static/*$|node_modules/*$'
let g:ctrlp_working_path_mode = 0 " Only search in directory that vim started off in (important for monorepos, otherwise it crawls up the tree and searches the entire repo)
set wildignore+=*.pyc
set wildignore+=*/providermatch_admin/public/*
set wildignore+=*/node_modules/*

" Vim-Fugitive
set diffopt+=vertical " make diffs open vertically instead of horizontally (ew)

" UltiSnips
let g:UltiSnipsExpandTrigger="<leader>*"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsSnippetDirectories = ['UltiSnips', $HOME.'/.config/UltiSnips']

" NERDTree shortcut
nnoremap <silent> <Leader>nt :NERDTree<CR>
nnoremap <Leader>e :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$'] " ignore certain file extensions

" Vim-Airline
let g:airline_section_z = '%l/%L'
let g:airline_section_y = '%Y'
let g:airline_section_x = ''
let g:airline_left_sep=''
let g:airline_right_sep=''

" Jedi-Vim
autocmd FileType python setlocal completeopt-=preview
let g:jedi#use_tabs_not_buffers=0
let g:jedi#popup_select_first=1
let g:jedi#show_call_signatures=0
let g:jedi#documentation_command = ""
let g:jedi#force_py_version = 3

"ALE
" Temporary fix since tslint doesn't respect the local prettierrc. Use global
" tsserver instead
let g:ale_linters = {'typescript': ['tsserver', 'eslint']}
autocmd FileType javascript,javascript.jsx,typescript,typescript.tsx nnoremap <buffer> <Leader>f :ALEFix eslint<CR>

" Specify fixers for different filetypes
let b:ale_fixers = {'svg': ['xmllint']}

" Deoplete
let g:deoplete#enable_at_startup = 1
" Tabs for scrolling
inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<tab>"
inoremap <expr><C-n> deoplete#mappings#manual_complete()


" Deoplete-Ternjs
autocmd FileType javascript.jsx nmap <buffer> <Leader>d :TernDef<CR>
autocmd FileType javascript.jsx nmap <buffer> <Leader>r :TernRename<CR>
autocmd FileType javascript.jsx nmap <buffer> <Leader>s :TernType<CR>

" Use tern_for_vim.
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]

" nvim-typescript
"autocmd FileType typescript,typescript.tsx nmap <buffer> <Leader>d :TSDef<CR>
"autocmd FileType typescript,typescript.tsx nnoremap <buffer> <Leader>D :TSDefPreview<CR>
"autocmd FileType typescript,typescript.tsx nmap <buffer> <Leader>r :TSRename<CR>
"autocmd FileType typescript,typescript.tsx nmap <buffer> <Leader>s :TSType<CR>
"autocmd FileType typescript,typescript.tsx nnoremap <buffer> <Leader>S :TSTypeDef<CR>

" LanguageClient-neovim
" How to start language servers
let g:LanguageClient_serverCommands = {
    \ 'typescript.tsx': ['typescript-language-server', '--stdio'],
    \ 'python': ['pyls', '-v'],
    \ }
" Requires neovim 0.4.0 dev build
let g:LanguageClient_useFloatingHover = 1
" Don't need virtual text, we have ALE for linting
let g:LanguageClient_useVirtualText = 0
" Disable diagnostics, they end up wiping the ctrl-p pane
let g:LanguageClient_diagnosticsEnable = 0
nnoremap <Leader>d :call LanguageClient#textDocument_definition()<CR>
nnoremap <Leader>D :call LanguageClient#textDocument_definition({'gotoCmd': 'split'})<CR>
nnoremap <Leader>r :call LanguageClient#textDocument_rename()<CR>
nnoremap <Leader>s :call LanguageClient#textDocument_hover()<CR>
nnoremap <Leader>S :call LanguageClient#textDocument_typeDefinition()<CR>

" Closetag
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.tsx,*.jsx'
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }
