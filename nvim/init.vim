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
call plug#end()

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
