filetype plugin indent on
syntax enable

" Plugins
call plug#begin('~/.vim/plugged')

  " Color schemes
  Plug 'jeffkreeftmeijer/vim-dim'
  Plug 'tyrannicaltoucan/vim-deep-space'
  Plug 'jacoborus/tender.vim'
  
  " Languages
  Plug 'FredTheDino/sylt.vim'
  
  " gitsigns
  Plug 'nvim-lua/plenary.nvim'
  Plug 'lewis6991/gitsigns.nvim'
  
  " Niceties
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'tpope/vim-fugitive'

  Plug 'psliwka/vim-smoothie'

  " TODO: triage
  Plug 'mbbill/undotree'
  Plug 'prabirshrestha/async.vim'
  Plug 'w0rp/ale'
  Plug 'tpope/vim-markdown'
  Plug 'cespare/vim-toml'
  Plug 'rust-lang/rust.vim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-compe'
  Plug 'gfanto/fzf-lsp.nvim', { 'branch': 'main' }
  Plug 'folke/lsp-colors.nvim'
  Plug 'simrat39/rust-tools.nvim'
  Plug 'nvim-lua/popup.nvim'
call plug#end()

" TODO: triage
set wildmode=longest,list,full
set wildmenu

let mapleader = "\<space>"
map <Leader>u :UndotreeToggle<CR>
autocmd VimResized * wincmd =

map <Leader>E :FZF<CR>
map <Leader>e :FZF<CR>

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.4, 'yoffset': 1, 'border': 'horizontal' } }
let g:fzf_preview_window = []

" don't give |ins-completion-menu| messages.  For example,
" '-- XXX completion (YYY)', 'match 1 of 2', 'The only match',
set shortmess+=c

" IMPORTANT: :help Ncm2PopupOpen for more information
" For better diagnostic messages with coc
set completeopt=noinsert,menuone,noselect

" Poor man's lsp context menu
let g:lsp_context_menu_commands = [
            \    'vim.lsp.buf.document_symbol()',
            \    'vim.lsp.buf.declaration()',
            \    'vim.lsp.buf.definition()',
            \    'vim.lsp.buf.implementation()',
            \    'vim.lsp.buf.type_definition()',
            \    'vim.lsp.buf.hover()',
            \    'vim.lsp.buf.references()',
            \    'vim.lsp.buf.formatting()',
            \    'vim.lsp.buf.outgoing_calls()',
            \    'vim.lsp.buf.incoming_calls()',
            \ ]

function Fzf_lsp_context_menu()
    call fzf#run({'sink': 'lua', 'source': g:lsp_context_menu_commands, 'down': 10})
endf

nmap <Leader>lc :call g:Fzf_lsp_context_menu()<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" colorscheme: tender
if (has("termguicolors"))
 set termguicolors
endif
colorscheme tender

" gitsigns: setup
lua require('gitsigns').setup()

" Persistent undo
if has('persistent_undo')
    set undodir=$XDG_DATA_HOME/nvim/undo
    set undofile
endif

" Filetype-specific
autocmd FileType lua,yml,markdown set shiftwidth=2
autocmd FileType snippets set shiftwidth=8
autocmd FileType tex,markdown,text set tw=80

" Set SignColumn color to same as line number
autocmd ColorScheme * highlight! link SignColumn LineNr

" lvimrc: setup
let g:localvimrc_ask = 0  " always load .lvimrc if it exists
let g:localvimrc_sandbox = 0  " nvim compat

" netrw: setup
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+' " hide dotfiles in netrw
let g:netrw_liststyle = 3  " set tree as default netrw-view

" keymap: window movement
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
nnoremap <c-w>v <c-w><c-v><c-w>l

au BufReadPost todo* set syntax=txt

set autoindent            " autoindent on newline?
set breakindent           " keep indent when wrapping
set clipboard=unnamedplus " use system clipboard
set encoding=utf-8        " utf-8
set expandtab             " convert all tabs to spaces
set hidden                " ?
set inccommand=split      " incrementally show search results in split window
set laststatus=2          " show two lines in the bottom
set linebreak             " only wrap at certain characters
set nocompatible          " disable vim-things
set nospell               " disable spellcheck
set number                " always show line-numbers
set scrolloff=5           " scrolloff
set shiftwidth=4          " 4 spaces
set statusline=\ %f\ %y%r%m%h%w%<%=%l:%2c\ (%L)\ 
set updatetime=100        " default: 4000ms
set wrap                  " ?

"TODO
lua << EOF
require('config/lsp')
--require('config/snip')
require('config/compe')
require('config/rust-tools')
--require('config/dap')
--require('config/neogit')
--require('config/keybinds')
EOF
