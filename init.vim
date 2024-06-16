call plug#begin('~/.local/share/nvim/plugged')
" Color scheme
Plug 'overcache/NeoSolarized'

" Status line
Plug 'nvim-lualine/lualine.nvim'

" Project Navigation
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'easymotion/vim-easymotion'

Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'qpkorr/vim-bufkill'
Plug 'tpope/vim-surround'
Plug 'windwp/nvim-autopairs'

" - Telescope
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" Requires font-hack-nerd-font
Plug 'kyazdani42/nvim-web-devicons'

" Language tooling
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'simrat39/symbols-outline.nvim'

" Autocomplete
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'

" Snippets
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

" Language Syntax
Plug 'dense-analysis/ale'
Plug 'alvan/vim-closetag'

" Jsonnet
Plug 'google/vim-jsonnet'

" Nginx
Plug 'chr4/nginx.vim'

call plug#end()

" Color scheme
set background=dark
colorscheme NeoSolarized

set nowrap

" General
set mouse=a "use mouse everywhere
set relativenumber  "turn on line numbers
set number
set ruler   "Always show current positions along the bottom
set showcmd "show the command being typed
set encoding=utf-8
set autoindent
set smartindent
set nocindent
" Prevent python comments or other characters from breaking indent
:inoremap # X<BS>#
set indentkeys-=0#,<:>
set cinkeys-=0#,<:>

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
" Avoid remapping tab in normal mode, so that CTRL-I works for moving around
" jumplist (Ctrl-I === <Tab>)
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

" Jump between buffers
nnoremap <C-,> :bp<CR>
nnoremap <C-.> :bn<CR>

" Movement Mappings, allow j/k to move one visual line even if wrapped
nnoremap j gj
nnoremap k gk

vnoremap j gj
vnoremap k gk

" Break line at cursor, inverse of J
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
autocmd FileType json,proto setlocal shiftwidth=4 tabstop=4
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
autocmd FileType python setlocal foldmethod=indent

" Restore the current buffer
function! BufDo(command)
  let currBuff=bufnr("%")
  execute 'bufdo ' . a:command
  execute 'buffer ' . currBuff
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
    local lspconfig = require'lspconfig'
    lspconfig.tsserver.setup{} -- Requires npm install -g typescript typescript-language-server
    -- Uncomment to switch python language sever impls
    -- lspconfig.pylsp.setup{} -- Requires pip install "python-lsp-server[all]"
    lspconfig.pyright.setup{} -- Requires npm install -g pyright


    -- RLS 2.0
    lspconfig.rust_analyzer.setup{}  -- brew install rust-analyzer

    -- Disable inline dianostics
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = false,
            signs = false,
            underline = false
        }
    )
EOF
nnoremap <Leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>

" ==========================
" -------TREE-SITTER--------
" ==========================
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"python", "rust", "typescript", "javascript", "tsx", "vim", "yaml"}, -- one of "all", or a list of languages
  indent = {
    enable = true
  },
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}
EOF
" ==========================
" ------- LUALINE ----------
" ==========================
lua <<EOF
require('lualine').setup {
  options = { theme = 'solarized_dark' },
}
EOF

" ==========================
" ------- NVIM-CMP----------
" ==========================
lua <<EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Repeat for each configured lsp server
  require('lspconfig')['tsserver'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['pyright'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['rust_analyzer'].setup {
    capabilities = capabilities
  }
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

" ~~~~~ TELESCOPE.VIM ~~~~~
nnoremap <Leader>ff <cmd>lua require('telescope.builtin').find_files()<CR>
nnoremap <Leader>fg <cmd>lua require('telescope.builtin').live_grep()<CR>
nnoremap <Leader>fb <cmd>lua require('telescope.builtin').buffers()<CR>
nnoremap <Leader>fh <cmd>lua require('telescope.builtin').help_tags()<CR>
" Keep my old Ack plugin bindings to make searching faster
nnoremap <Leader>a <cmd>lua require('telescope.builtin').live_grep()<CR>
xnoremap <Leader>a <cmd>lua require('telescope.builtin').grep_string()<CR>
" Keep my old ctrl-p plugin binding to make searching files faster
nnoremap <Leader>t <cmd>lua require('telescope.builtin').find_files()<CR>

lua <<EOF
    require('telescope').setup {
        pickers = {
            find_files = {
                hidden = true
            },
            live_grep = {
                hidden = true
            }
        },
        defaults = {
            file_ignore_patterns = {
                "node_modules",
                ".git"
            }
        }
    }
EOF

" ~~~~~ SymbolsOutline ~~~~~
lua << EOF
    require("symbols-outline").setup {
        keymaps = { -- These keymaps can be a string or a table for multiple keys
            close = {"<Esc>", "q"},
            goto_location = "<CR>",
            focus_location = "<S-CR>",
            hover_symbol = "<Leader>s",
            toggle_preview = "K",
            rename_symbol = "r",
            code_actions = "a",
            fold = "x",
            unfold = "o",
            fold_all = "X",
            unfold_all = "O",
            fold_reset = "R",
          }
    }
EOF
nnoremap <Leader>o :SymbolsOutline<CR>

" ~~~~~ Vim-Fugitive ~~~~~
set diffopt+=vertical " make diffs open vertically instead of horizontally (ew)

" ~~~~~ nvim-tree ~~~~~~~
lua << EOF
  require("nvim-tree").setup()
EOF
nnoremap <Leader>e :NvimTreeToggle<CR>


" ~~~~~ ALE ~~~~~
nnoremap <Leader>F :ALEFix<CR>

" Fixer for jsonnet files
autocmd FileType jsonnet nnoremap <buffer> <Leader>f :w<CR>:silent !jsonnetfmt --comment-style s --string-style d -i %<CR>

" Specify fixers for different filetypes
let g:ale_fixers = {
    \ 'svg': ['xmllint'],
    \ 'python': ['black', 'isort'],
    \ 'javascript': ['prettier'],
    \ 'typescript': ['prettier'],
    \ 'rust': ['rustfmt'],
    \ }
let g:ale_linters = {
    \ 'python': ['pylint'],
    \ }

let g:ale_javascript_prettier_executable = 'prettierd'

" Set MYPYPATH explicitly if we're in a virtualenv
if !empty($VIRTUAL_ENV)
    let $MYPYPATH = $VIRTUAL_ENV.''
else
endif

" ~~~~~ Closetag ~~~~~
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.tsx,*.jsx,*.js'
let g:closetag_xhtml_filenames = '*.tsx,*.jsx'
let g:closetag_regions = {
    \ 'typescriptreact': 'jsxRegion,tsxRegion',
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ 'javascript': 'jsxRegion',
    \ }

" ~~~~~ Autopairs ~~~~~
lua << EOF
require("nvim-autopairs").setup {}
EOF

" ~~~~~ jsonnet ~~~~~
let g:jsonnet_fmt_on_save = 0

" Load custom settings
source $HOME/.config/nvim/custom.vim
