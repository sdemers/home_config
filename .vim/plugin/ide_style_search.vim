if exists('ide_style_search')
    finish
endif
let ide_style_search=1

function! IdeStyleSearch(where, pattern)
    " Clears the quickfix window
    call setqflist([])

    " get current buffer to jump back to it (bufdo jumps to last buffer)
    let l:currentb = expand("%:p")

    exe "silent! ".a:where." vimgrepadd /".a:pattern."/j %"
    exe "silent! buffer ".l:currentb
    exe "copen"
endfunction

" Adjust quickfix window, up to 20 lines
au FileType qf call AdjustWindowHeight(3, 20)
function! AdjustWindowHeight(minheight, maxheight)
    exe max([min([line("$")+1, a:maxheight]), a:minheight]) . "wincmd _"
endfunction

" Search for a word (current file, buffers, tabs)
command! -nargs=1 GF :call IdeStyleSearch("", <q-args>)
command! -nargs=1 GB :call IdeStyleSearch("bufdo", <q-args>)
command! -nargs=1 GT :call IdeStyleSearch("tabdo", <q-args>)

" Search word under cursor (current file, buffer, tabs)
command! GWF :call IdeStyleSearch("", expand('<cword>'))
command! GWB :call IdeStyleSearch("bufdo", expand('<cword>'))
command! GWT :call IdeStyleSearch("tabdo", expand('<cword>'))
