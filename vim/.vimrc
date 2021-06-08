call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'bling/vim-airline'
Plug 'jiangmiao/auto-pairs'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'airblade/vim-gitgutter'
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'luochen1990/rainbow'
Plug 'rust-lang/rust.vim'
Plug 'preservim/tagbar'
Plug 'lervag/vimtex'
Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'
Plug 'neoclide/coc-rls'
Plug 'ap/vim-css-color'
Plug 'kien/ctrlp.vim'
Plug 'rafamadriz/friendly-snippets'
Plug 'hrsh7th/vim-vsnip'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
Plug 'alec-gibson/nvim-tetris'
Plug 'ThePrimeagen/vim-be-good'
Plug 'tjdevries/train.nvim'

call plug#end()

let g:coc_global_extensions = [
	\ 'coc-rust-analyzer',
	\ 'coc-git',
	\ 'coc-tsserver',
	\ 'coc-yaml',
	\ 'coc-python',
	\ 'coc-prettier',
	\ 'coc-toml',
	\ 'coc-clangd',
	\ 'coc-markdownlint',
	\ 'coc-xml',
	\ 'coc-tabnine',
	\ 'coc-sh',
	\ 'coc-yaml',
	\ 'coc-json',
	\ 'coc-html',
	\ 'coc-css',
	\ ]

set laststatus=2

colorscheme gruvbox
syntax on
set mouse=a
set number
set autoread
set autoindent
set hlsearch
set ignorecase
set incsearch
set smartcase
set linebreak
set wrap
set wildmenu
set cursorline
set relativenumber
set title
set background=dark
set history=1000

let g:rainbow_active = 1

nmap <C-n> :NERDTreeToggle<CR>
nmap <C-k> :Tagbar<CR>
syntax enable
filetype plugin indent on
let g:rustfmt_autosave = 1

