call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'ollykel/v-vim'
Plug 'bling/vim-airline'
Plug 'jiangmiao/auto-pairs'
Plug 'justmao945/vim-clang'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fannheyward/coc-rust-analyzer'
Plug 'josa42/coc-sh'
Plug 'neoclide/coc-vimtex'
Plug 'dag/vim-fish'
Plug 'airblade/vim-gitgutter'
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'racer-rust/vim-racer'
Plug 'luochen1990/rainbow'
Plug 'rust-lang/rust.vim'
Plug 'preservim/tagbar'
Plug 'lervag/vimtex'
Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'
Plug 'neoclide/coc-rls'

call plug#end()

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

