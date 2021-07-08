call plug#begin('~/.vim/plugged')

Plug 'sickill/vim-monokai'
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
Plug 'dense-analysis/ale'
Plug 'ap/vim-css-color'
Plug 'kien/ctrlp.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
Plug 'jceb/vim-orgmode'
Plug 'plasticboy/vim-markdown'
Plug 'georgewitteman/vim-fish'
Plug 'easymotion/vim-easymotion'
Plug 'universal-ctags/ctags'
Plug 'vim-syntastic/syntastic'

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
	\ 'coc-sh',
	\ 'coc-yaml',
	\ 'coc-json',
	\ 'coc-html',
	\ 'coc-css',
	\ 'coc-vimtex',
	\ ]

set laststatus=2

colorscheme monokai
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

