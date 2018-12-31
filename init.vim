call plug#begin('~/.local/share/nvim/plugged')
" Color scheme
Plug 'altercation/solarized'

" Status line
Plug 'bling/vim-airline'

" Project Navigation
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'

Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'qpkorr/vim-bufkill'

" Language Syntax
Plug 'w0rp/ale'

" Language Autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'zchee/deoplete-jedi'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}

" Python
Plug 'davidhalter/jedi-vim'

" Javascript
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'

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

" Break line at cursor
nnoremap K i<CR><Esc>
" Switch to last file
nmap <C-e> :e#<CR>

" Tabs
set tabstop=4
set shiftwidth=4
set expandtab
set list listchars=tab:»·,trail:·

" Change tab width depending on type (e.g. 4 for python, 2 for ruby)
autocmd FileType ruby,htmldjango.html,mustache.html,html.handlebars setlocal shiftwidth=2 tabstop=2
autocmd FileType python setlocal shiftwidth=4 tabstop=4
autocmd FileType json,proto setlocal shiftwidth=2 tabstop=2
autocmd FileType pug setlocal shiftwidth=2 tabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd FileType javascript.jsx setlocal shiftwidth=2 tabstop=2
autocmd FileType typescript.tsx setlocal shiftwidth=2 tabstop=2
autocmd FileType typescript setlocal shiftwidth=2 tabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2
autocmd FileType sass setlocal shiftwidth=2 tabstop=2
autocmd FileType salt setlocal shiftwidth=2 tabstop=2
autocmd FileType tsv setlocal noexpandtab shiftwidth=20 tabstop=20  " Disable tab-to-spaces for tsv's


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
set wildignore+=*.pyc
set wildignore+=*/providermatch_admin/public/*
set wildignore+=*/node_modules/*

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

" Deoplete
let g:deoplete#enable_at_startup = 1

" Deoplete-Ternjs
autocmd FileType javascript.jsx nmap <buffer> <Leader>d <Plug>(TernDef)
autocmd FileType javascript.jsx nmap <buffer> <Leader>r <Plug>(TernRename)
autocmd FileType javascript.jsx nmap <buffer> <Leader>s : <Plug>(TernType)

" nvim-typescript
autocmd FileType typescript nmap <buffer> <Leader>d <Plug>(TSDef)
autocmd FileType typescript nmap <buffer> <Leader>r <Plug>(TSRename)
autocmd FileType typescript nmap <buffer> <Leader>s : <Plug>(TSType)
autocmd FileType typescript nmap <buffer> <Leader>S : <Plug>(TSTypeDef)
