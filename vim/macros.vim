" q key will quit in command mode.
nmap q :q<CR>

" CTRL-l to unhighlight search results and redraw the screen
nmap <C-l> :nohlsearch<CR>:redraw!<CR>

" CTRL-n and CTRL-p to go forwards and backwards through files
nmap <C-n> :next<CR>
nmap <C-p> :prev<CR>

" Press CTRL-z after pasting something to fix up formatting
imap <C-z> <ESC>u:set paste<CR>.:set nopaste<CR>i

" Tab to switch between split windows
nmap <Tab> <C-w><C-w>

" I frequently type :Q, :W, or :Wq, instead of :q, :w, and :wq respectively
command! Q :q
command! W :w
command! Wq :wq

" Toggle word wrap
function ToggleWrap()
    if &wrap
        setlocal nowrap
        echo "Word wrap off"
    else
        setlocal wrap
        echo "Word wrap on"
    endif
endfunction

" Toggle show invisible characters
function ToggleInvisibles()
    if &list
        setlocal nolist
        echo "Invisible characters on"
    else
        setlocal list
        echo "Invisible characters off"
    endif
endfunction

" Spell checking mode toggle
function ToggleSpelling()
    if &spell
        setlocal nospell
        echo "Spell check off"
    else
        setlocal spell
        echo "Spell check on"
    endif
endfunction

" Function key mappings
map <F8> :call ToggleSpelling()<CR>
imap <F8> <C-o>:call ToggleSpelling()<CR>
map <F9> :call ToggleInvisibles()<CR>
imap <F9> <C-o>:call ToggleInvisibles()<CR>
map <F10> :call ToggleWrap()<CR>
imap <F10> <C-o>:call ToggleWrap()<CR>
