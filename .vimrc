syntax on
syntax enable
set background=dark
set t_Co=256
let g:solarized_termcolors = 16
colorscheme solarized
set backup
set backupdir=~/.vim/backup

set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start		" allow backspacing over everything in insert mode
set ai			" always set autoindenting on
"set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set wrap linebreak textwidth=0

" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup fedora
  autocmd!
  " In text files, always limit the width of text to 78 characters
  " autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  " start with spec file template
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif

if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  syntax enable
  set hlsearch
endif

filetype plugin on

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"

" CUSTOM SETTINGS

" General
set mouse=a "use mouse everywhere
set relativenumber  "turn on line numbers
set ruler   "Always show current positions along the bottom
set showcmd "show the command being typed

set laststatus=2
set statusline=%f "tail of filename
set statusline+=\ \[%{&ff}] "file format
set statusline+=%h "help file flag
set statusline+=%m "modified flat
set statusline+=%r "read only flag
set statusline+=%y "filetype
set statusline+=%= "left/right separator
set statusline+=%l/%L "cursor line/total line
set statusline+=\ %P "percent through file

" Tabs
set tabstop=4
set shiftwidth=4
set expandtab

" Pymode custom settings
set foldlevelstart=2
let g:pymode_lint_checker="pyflakes,mccabe"

" File Extensions
au BufNewFile,BufRead *.hql set filetype=sql
au BufNewFile,BufRead *.html set filetype=htmldjango

" Change tab width depending on type
autocmd FileType ruby,htmldjango setlocal shiftwidth=2 tabstop=2
autocmd FileType python setlocal shiftwidth=4 tabstop=4

" Mappings"
" Map up/down to next/prev buffer 
map <up> <ESC>:bn<RETURN> 
map <down> <ESC>:bp<RETURN> 
" Map left/right to prev/next tab
map <left> <ESC>gT 
map <right> <ESC>gt 

nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-l> :wincmd l<CR>

" Relative/Absolute line numbers
function! NumberToggle()
    if(&relativenumber == 1)
        set number
    else
        set relativenumber
    endif
endfunc

nnoremap <silent> `<C-n> :call NumberToggle()<CR>

" Save and Quit maps
:command W w
:command Q q

" ---------PLUGINS----------
" Pathogen
call pathogen#infect()
call pathogen#helptags()

" Remap Command-T Buffers
nnoremap <silent> <Leader>bt :CommandTBuffer<CR>

" NERDTree shortcut
:command NT NERDTree

" Bufexplorer customizations
let g:bufExplorerShowRelativePath=1
let g:bufExplorerSortBy='fullpath'
let g:bufExplorerSplitOutPathName=0

" Syntastic
let g:syntastic_enable_signs=1
let g:synastic_enable_highlighting=1
let g:syntastic_ruby_exec='~/.rvm/rubies/ruby-2.0.0-p247/bin/ruby'
