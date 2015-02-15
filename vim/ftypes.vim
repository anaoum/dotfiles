" Enable filetype detection, plugin and indent
filetype plugin indent on

" Assume LaTeX for .tex files
let g:tex_flavor = "latex"

" Set options based on filetypes, overrides the filetype plugin/indent options
autocmd FileType bib setlocal sts=2 sw=2 ts=2 tw=80 fo-=tc
autocmd FileType tex setlocal sts=2 sw=2 ts=2 tw=80 fo-=tc
autocmd FileType xml setlocal sts=2 sw=2 ts=2
autocmd FileType html setlocal sts=2 sw=2 ts=2
autocmd FileType css setlocal sts=2 sw=2 ts=2
autocmd FileType python setlocal tw=80 fo-=t

" Use blowfish encryption
set cryptmethod=blowfish2

" Character encodings to consider when starting to edit an existing file
set fileencodings=ucs-bom,utf-8,utf-16le,default,latin1
