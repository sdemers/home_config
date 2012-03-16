" Vim plugin for switching between .h/.hpp and .c/.cpp files

let s:paths = [".", "../include", "../code", "../source", "../src"]
let s:extsrc = ["c", "cxx", "cc", "cpp"]
let s:extheader = ["h", "hpp", "hxx"]

" don't load twice
if exists("loaded_switch_headers")
    finish
endif
let loaded_switch_headers = 1

function! SwitchHelper(path, ext)
    let currext = expand("%:e")
    let tosearch = substitute(expand("%:t"), currext, a:ext, "")

    try
        exec "find " . a:path . "/" . tosearch
        return 1
    catch
    endtry

    return 0
endfun

function! TrySwitch(to)
    for path in s:paths
        for ext in a:to
            if SwitchHelper(path, ext) > 0
                return
            endif
        endfor
    endfor
endfun


" open header/source
function! SwitchHeader()
    if index(s:extsrc, expand("%:e")) >= 0
        call TrySwitch(s:extheader)
    else
        call TrySwitch(s:extsrc)
    endif
endfun

nnoremap <C-H>  :call SwitchHeader()<CR>
