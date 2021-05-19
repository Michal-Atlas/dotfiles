set laststatus=2
syntax on
set mouse=a
set ttymouse=xterm2
set number
colorscheme molokai
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
"set relativenumber
set title
set background=dark
set history=1000

let g:rainbow_active = 1

nmap <C-n> :NERDTreeToggle<CR>
nmap <C-k> :Tagbar<CR>
syntax enable
filetype plugin indent on
let g:rustfmt_autosave = 1

