source $VIMRUNTIME/defaults.vim

set backup
set undofile
set directory=~/.state/vimswp//
set backupdir=~/.state/vimbak//
set undodir=~/.state/vimund//
set viminfofile=~/.state/viminfo
let g:netrw_home="~/.state"

set mouse=a
set title
set number
highlight LineNr ctermfg=Grey

set listchars=tab:»·,extends:›,precedes:‹,nbsp:·,trail:·,space:·,eol:$
set showbreak=↳\ 

set expandtab
set softtabstop=4
set shiftwidth=4
set autoindent
set smartindent
set copyindent

set hlsearch
set ignorecase
set smartcase

nmap <C-n> :next<CR>
nmap <C-p> :prev<CR>

vmap <C-c> y:echo system('cat > /dev/tcp/127.0.0.1/2547', getreg(''))<CR>
vmap <C-x> x:echo system('cat > /dev/tcp/127.0.0.1/2547', getreg(''))<CR>
