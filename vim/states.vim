" Remember marks for 100 files in viminfo
set viminfo='100
" Store a maximum of 1000 lines in each register in viminfo
set viminfo+=<1000
" Keep 1000 lines of command history in viminfo
set history=1000
" Store viminfo file in the ~/state directory
set viminfofile=~/.state/viminfo

" Make a backup (i.e. 'file~') and save it
set backup
" Store backup files in the ~/.state directory
set backupdir=~/.state/vimbak

" Store swap files in the ~/.state directory
set directory=~/.state/vimswp//

" Allow undos to persist
set undofile
" Store undo files in the ~/.state directory
set undodir=~/.state/vimund

" Disable creation of .netrwhist file
let g:netrw_dirhistmax=0

" Jump to the last position when reading a file
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |    exe "normal g'\""
    \ | endif
