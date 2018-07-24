" Pretty syntax highlighting
syntax on

" Show line and character numbers
set ruler

" Word wrap off initially
set nowrap

" When a bracket is inserted, briefly jump to the matching one
set showmatch

" Show the filename title in xterm and tmux
set title
" Custom titlestring to use
autocmd BufEnter *
    \ let &titlestring = "vim "
    \ . expand("%")
    \ . " (" . system('hostname -s')[:-2] . ")"
" xterm escape sequence for setting both tab and window title is ESC]0;stringBEL
set t_ts=]0;
set t_fs=

" Make the autocompletion show a list of options
set wildmode=list

" Match search results as you type
set incsearch

" Ignore case when searching
set ignorecase

" Ignore the ignorecase setting if search contains uppercase chars
set smartcase

" Highlight search terms
set hlsearch

" Use a dark background
set background=dark

" How to display invisible characters when list is enabled
set listchars=tab:»·,extends:›,precedes:‹,nbsp:·,trail:·,space:·,eol:$
set showbreak=↳\ 

" Set the language to use for spell check.
set spelllang=en_au

" Mark the ideal max text width
set colorcolumn=+1
