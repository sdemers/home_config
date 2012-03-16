" Vim plugin for switching between .h/.hpp and .c/.cpp files
" Inspired by: http://vim.sourceforge.net/tips/tip.php?tip_id=384
" Maintainer: Slavomir Smutny <slavos1@gmail.com>
" Version: 1.2
" Last Change: 2006 August 31

"don't load twice, we don't like that...
if exists("loaded_switch_headers")
    finish
endif
let loaded_switch_headers = 1

"save current 'compatible' state and make vim compatible
let cpo_save = $cpo
set cpo&vim

function! SwitchHelper(ext)
    let currext = expand("%:e")
    let tosearch = substitute(expand("%:t"), currext, a:ext, "")
    try
        exec "find " . tosearch
    catch
        try
            exec "find ../include/" . tosearch
        catch
        try
            exec "find ../code/" . tosearch
        catch
        try
            exec "find ../src/" . tosearch
        catch
        try
            exec "find ../source/" . tosearch
        catch
            return 0
        endtry
        endtry
        endtry
        endtry
    endtry

    return 1
endfun


" open header/source in new window
function! SwitchHeader()
    if &ft == 'c' || &ft == 'cxx' || &ft == 'cc' || &ft == 'cpp'
        if expand('%:e') == 'h' || expand('%:e') == 'hxx'
            if SwitchHelper("c") || SwitchHelper("cxx") || SwitchHelper("cc") || SwitchHelper("cpp")
                return
            endif
        else
        if SwitchHelper("h") || SwitchHelper("hpp")
            return
        endif
    endif
endfun

"return to previous 'compatibility' state
let &cpo = cpo_save

nnoremap <C-H>  :call SwitchHeader()<CR>
filetype on
