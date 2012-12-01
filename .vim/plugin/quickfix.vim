if exists('loaded_quickfix')
    finish
endif
let loaded_quickfix=1

" toggles the quickfix window.
command -bang -nargs=? FixQuick call QFixToggle(<bang>0)
function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
  else
    copen 15
  endif
endfunction

function! QFixBufEnter()
    let g:qfix_win = bufnr("$")
    nmap <buffer> <CR> :call QFixEnter()<CR>
endfunction

function! QFixBufLeave()
    if exists("g:qfix_win") && expand("<abuf>") == g:qfix_win
        unlet! g:qfix_win
        mapclear <buffer>
    endif
endfunction

" used to track the quickfix window
augroup QFixToggle
 autocmd!
 autocmd BufWinEnter quickfix call QFixBufEnter()
 autocmd BufWinLeave *        call QFixBufLeave()
augroup END

" Quickfix window shortcuts
nmap <Leader>q :FixQuick<CR>
nmap <Leader>g :.cclose<CR>

function! QFixEnter()
    if getbufvar('%', '&buftype') == 'quickfix'
        exec '.cc'
    endif
endfunction
