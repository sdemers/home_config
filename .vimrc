set nowrapscan
set nowrap
set tabstop=4
set expandtab
set ruler
set shiftwidth=4


" This line will make Vim trailing whitespace and invisible spaces visually,
" and additionally use the # sign at the end of lines to mark lines that extend off-screen. For more
" info, see :h listchars.
" set list
" set listchars=tab:>-,trail:.,extends:#,nbsp:.

" enable loading the plugin files for specific file types
"set nocp
"filetype plugin on
"filetype indent off
"set formatoptions=
" I only use this for omni completion, the default ftplugin sets formatoptions
" and I hate that.
" let b:did_ftplugin = 1

syntax on

set viminfo='10,\"100,:20,%,n~/.viminfo

au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" close preview window after selecting auto-completion
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" indentation
" set softtabstop=4
" set smartindent
set cino=(0
set cinkeys=0{,0},:,0#,!<Tab>,!
set backspace=indent,eol,start

" number of screen lines to keep above and below the cursor.
set scrolloff=10

" command completion shows matching commands
set wildmenu

" use confirm instead of aborting an action
set confirm

" current directory is always matching the content of the active window
set autochdir

" put swap files in /tmp
set swapfile
set dir=/tmp

set tags=tags,TAGS,$LOCALROOT/tags.localroot,$LOCALROOT/tags.pjroot

set backup
set backupdir=/tmp/vim_files/,/tmp

" Custom color setting
highlight Visual ctermbg=2

" don't invoke a new shell when executing commands
set shellcmdflag=-fc

" read per-file custom settings
set modeline

" Start searching when you type the first character of the search string. As you
" type in more characters, the search is refined.
set incsearch

" Hilight searched words
set hlsearch

" Disable search highlight by hitting <CR>
nnoremap <CR> :noh<CR>

" However sometimes matching case is important. Usually this is with cases involving
" upper-case or mixed-case search strings. This command assumes that a search string
" is case-sensitive if it contains any upper-case characters:
set ignorecase
set smartcase

"
" Comments settings
"
" Format is: /*
"            **
"            */
" set comments=s:/*,mb:**,ex:*/,b://,b:#,b:%,b:\"
" set formatoptions=ro
"
set formatoptions=
set comments=

" move down and up by screen lines instead of file lines
" (will not jump when moving up or down wrapped lines)
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" unmap Shift-L (brings the cursor at the end of the page, I HATE THAT)
nnoremap <S-L> <ESC>

" ignore F1 key
map <F1> <Nop>

nmap hf o//------------------------------------------------------------------------------<CR>//<ESC>
nmap hx o//------------------------------------------------------------------------------<CR>/**<CR><CR><CR>*///----------------------------------------------------------------------------<ESC>0kk
cmap ,cp r ~/src/copyright<CR><ESC>kdd

cab Newclass :r ~/src/newclass

" map CTRL-LEFT, CTRL-RIGHT, CTRL-UP, CTRL-DOWN
nmap Od b
nmap Oc w
nmap Oa <Up>
nmap Ob <Down>

inoremap Od <Esc>bi
inoremap Oc <Esc>wwi
inoremap Oa <Esc><Up>a
inoremap Ob <Esc><Down>a

nmap [D      b
nmap [C      w

" map tab and backspace in command mode to jump word
nmap <Tab> w
nmap <BS>  b

" map 'E' to delete the rest of the line and append
nmap E Da

" map Home and End to go on start/end of line
nmap [1~ 0
nmap [4~ $
imap [1~ 0I
imap [4~ A

" map Enter key on keypad to Enter
nmap OM  <CR>
imap OM  <CR>

" map CTRL-PageUp and CTRL-PageDown
nmap [6^ G
nmap [5^ :1

" map Delete key on dd
nmap [3~ dd

" map f key on search for next function
nmap f /PUBLIC\\|PRIVATE<CR>

" I always type :Wq and :WQ
cmap :WQ wq
cmap :Wq wq

" disable Q (ex mode)
map Q <nop>

nmap cpb o/* Start of "C" language include files */<CR>#ifdef __cplusplus<CR>extern "C" {<CR>#endif<CR><ESC>
nmap cpe o/* End of "C" language include files */<CR>#ifdef __cplusplus<CR>}<CR>#endif<CR><ESC>

function! CodeCleanup()
    if search('( ', 'n', line('.'))
        execute ':s/( /(/g'
    endif

    if search(' )', 'n', line('.'))
        execute ':s/ )/)/g'
    endif

    echo search("if\(", 'n', line('.'))
    if search('if(', 'c', line('.'))
        execute ':s/if(/if (/g'
    "if search('\(if\\|for\\|while\\|switch\)(', 'n', line('.'))
        "execute ':s/\(if\\|for\\|while\\|switch\)(/\1 (/g'
    endif

    "execute ':s/,\([A-Za-z]\)/, \1/g'
endfun

" Reindent everything in the file
nmap 123q :s/( /(/g:s/ )/)/g:s/if(/if (/g:s/while(/while (/g:s/for(/for (/g
vnoremap (      :s/( /(/g<CR>,:s/ )/)/g<CR>
vnoremap )      :s/ )/)/g<CR>
nnoremap (      :s/( /(/g<CR>
nnoremap )      :s/ )/)/g<CR>
nnoremap _      :s/\(if\\|for\\|while\\|switch\)(/\1 (/g<CR>
"nnoremap _      :call CodeCleanup()<CR>
nnoremap <C-S-P> :s/\([ ]*\)\([*&]\)/\2\1/<CR>

cmap ,sc s/(\(.\{-}\))\(.*\);/static_cast<\1\>(\2);

map  <C-L>   <Esc>:make lib<CR>
map <C-F7>  <Esc>:!redo all<CR>
cmap Mt      !maketags

" abbreviations
abbr cosnt  const
abbr Obejct Object
abbr obejct object
abbr fasle  false
abbr trie   true
abbr truie  true

" taglist plugin variables
" let Tlist_Show_Menu = 1
" let Tlist_Show_One_File = 1
" let Tlist_Exit_OnlyWindow = 1
" let Tlist_Inc_WinWidth = 1
" let Tlist_Sort_Type = "name"

if has("gui_running")
    colorscheme nuvola
    set guifont=Inconsolata\ 10
    " let Tlist_Auto_Open = 0
endif

if has("cscope") && !exists("isCscopeLoaded")
    cscope add $LOCALROOT

    let isCscopeLoaded = 1

    " don't let cscope take over tags
    set nocscopetag
endif

" use ctags plugin to display function name in status bar
" let g:ctags_statusline=1
" let g:ctags_title=1
" let generate_tags=1

highlight Tab ctermbg=red guibg=red
au Syntax c    syn match Tab /\t/
au Syntax cpp  syn match Tab /\t/

au Syntax c    syn keyword cTodo contained TODO FIXME XXX @todo \todo
au Syntax cpp  syn keyword cTodo contained TODO FIXME XXX @todo \todo

" highlight PoorWhiteSpace ctermbg=grey guibg=grey
" au Syntax * syn match PoorWhiteSpace /^[\ ]*/
" au Syntax * syn match PoorWhiteSpace /[^\t]+\zs\t+/
" au Syntax * syn match PoorWhiteSpace /\zs\ +$/

autocmd BufRead * highlight BadWhitespace ctermbg=yellow guibg=yellow
autocmd BufRead * match BadWhitespace /^\t\+/
autocmd BufRead * match BadWhitespace /\s\+$/

" move to upper/lower window
map <C-j> <C-W>j
map <C-k> <C-W>k

let g:ccaseNoComment=1

" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 1
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
" au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest

set path+=./
"set path+=$LOCALROOT/LINK/include/irts/
"set path+=$BOOST_ROOT/include/

" search word under cursor with Ack
nnoremap ,w :Ack <C-R><C-W> <CR>
nnoremap ,a :Ack

" show tag list for word under cursor
nnoremap ,t :ts <C-R><C-W><CR>

cmap Derived   r ~/src/derived.txt
cmap Derived.h r ~/src/derived_h.txt
cmap Abstract  r ~/src/abstract.txt

" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif
