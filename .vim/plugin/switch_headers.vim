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

" open header/source in new window
function! SwitchHeader()
    if &ft == 'c' || &ft == 'cxx' || &ft == 'cc' || &ft == 'cpp'
        if expand('%:e') == 'h' || expand('%:e') == 'hxx'
            try
                find %:t:r.c
            catch
            endtry
            try
                find %:t:r.cxx
            catch
            endtry
            try
                find %:t:r.cc
            catch  
            endtry
            try
                find %:t:r.cpp
            catch  
            endtry
        else
            try
                find %:t:r.h
            catch
            endtry
            try
                find %:t:r.hxx
            catch
            endtry
            try
                find %:t:r.hpp
            catch
            endtry
        endif
    endif
endfun

"return to previous 'compatibility' state
let &cpo = cpo_save

nnoremap <C-H>  :call SwitchHeader()<CR>
filetype on
