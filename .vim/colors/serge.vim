" Vim color file
"
" Maintainer:   Stefan Karlsson <stefan.74@comhem.se>
" Last Change:  29 September 2004
"

set background=light

hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name="serge"


"= Syntax Groups =============================================

hi normal       guibg=#f0edc1                   gui=none

hi comment                      guifg=#886633   gui=none

hi constant                     guifg=#008800   gui=none
hi specialchar                  guifg=#008800   gui=underline

hi identifier                   guifg=#0033aa   gui=none

hi statement                    guifg=#0033aa   gui=none
hi label                        guifg=#0033aa   gui=none

hi preproc                      guifg=#0033aa   gui=none
hi include                      guifg=#0033aa   gui=none
hi precondit                    guifg=#cc00cc   gui=none

hi type                         guifg=#0033aa   gui=none

hi special                      guifg=#cc00cc   gui=none

hi error        guibg=#ff3333   guifg=#ffffff   gui=none

hi todo         guibg=#339933   guifg=#ffffff   gui=none


"= General Groups ============================================

hi cursor       guibg=#000000   guifg=#ffffff   gui=none

hi directory                    guifg=#0033aa   gui=none

hi diffadd      guibg=#66ff66   guifg=#000000   gui=none
hi diffdelete   guibg=#ff6666   guifg=#ff6666   gui=none
hi diffchange   guibg=#ffff00   guifg=#cccc99   gui=none
hi difftext     guibg=#ffff00   guifg=#000000   gui=none

hi errormsg     guibg=#ff3333   guifg=#ffffff   gui=none

hi vertsplit    guibg=#0033aa   guifg=#0033aa   gui=none

hi folded       guibg=#eeeeee   guifg=#0033aa   gui=none
hi foldcolumn   guibg=#eeeeee   guifg=#999999   gui=none

hi linenr                       guifg=#bbbbbb   gui=none

hi modemsg                      guifg=#999999   gui=none

hi moremsg      guibg=#339900   guifg=#ffffff   gui=none
hi question     guibg=#339900   guifg=#ffffff   gui=none

hi nontext                      guifg=#999999   gui=none

hi normal                       guifg=#000000   gui=none

hi search       guibg=#ffff00   guifg=#000000   gui=none
hi incsearch    guibg=#ffbb00   guifg=#000000   gui=none

hi specialkey                   guifg=#cc00cc   gui=none

hi statusline   guibg=#0033aa   guifg=#ffffff   gui=none
hi statuslinenc guibg=#0033aa   guifg=#999999   gui=none

hi title                        guifg=#6666ff   gui=none

hi visual       guibg=#ff8833   guifg=#333333   gui=none

hi warningmsg                   guifg=#ff0000   gui=none

hi wildmenu     guibg=#339900   guifg=#ffffff   gui=none


" [eof]

