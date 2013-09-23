# PS1='\[\e[1;30m\](\[\e[36m\]\h\[\e[30m\]) [\[\e[34m\]\w\[\e[30m\]]\[\e[32m\] >\[\e[0m\] '
PS1='(`date +%H:%M`) \u [\w]> '

alias ls="ls --color -F"
alias ll="ls --color -lF"
alias l="ll"
alias la="ls -a"

alias reh='source ~/.bashrc'
alias rehash='reh'
alias sc='reh'
alias h='history'
alias j='jobs -l'
alias which='type -a'
alias ..='cd ..'
alias ebash='vi ~/.bashrc; source ~/.bashrc'
unalias j

export FIGNORE=.svn:.o:.hi
export TERM="xterm-256color"

# Read custom dircolors
eval `dircolors $HOME/.dircolors.conf`

# autojump
[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && . ~/.autojump/etc/profile.d/autojump.sh

ct ()
{
    if [ "`pwd`" = "${LOCALROOT}" ]; then
        cd ${LOCALVIEW}
        cleartool $* 2>&1 | grep -v "No such file or directory."
        cd -
    else
        cleartool $*
    fi
}

tt ()
{
    echo $*
    echo "$@"
    echo "\$*"
}

lsp ()
{
    if [ "$*" = "" ]; then
        ls -l ~/.project.*
    else
        ls -l ~/.project.* | grep $*
    fi
}

geninclude ()
{
    uuid | sed -e 's/-//g' | xargs echo INCLUDE_ | sed -e 's/[ ]//g'
}

findUnpushed()
{
    find ~ -type d -name .git -execdir zsh -c 'git branch --abbrev=1 -v | sed "s/^\*\s*//" | \grep ahead | awk "{ print \"$(pwd | sed "s/^\/home\/[^\/]*/~/")\" \$0 }"' \;
}

# Find a file with a pattern in name:
function ff() { find . -type f -iname '*'$*'*' ; }
function f() { find . -iname '*'$*'*' | grep -v ".git\|LINK\|.svn" ;}

function np ()
{
    if [ ! -f ~/.project.$1 ]; then
        echo "Project '$1' doesn't exist."
        return
    fi

    ln -sf ~/.project.$1 ~/.project
    source ~/.project

    cd ${LOCALROOT}
    pwd
}

c()
{
    dir=$1
    cd ${!dir}
}

vg()
{
    files=$(find . -name "*.c" -o -name "*.cpp" -o -name "*.cxx" -o -name "*.c" -o -name "*.h" -o -name "*.hpp" -o -name "*.d" -o -name "*.hs" 2>/dev/null)
    matches=$(grep -l $1 ${files} | sort)

    vi ${matches}
}

function vf()
{
    local file=$(find . -name "$1")
    local editor=${EDITOR:-vim}
    if [ ! -z ${file} ]; then
        ${editor} ${file} $2
    fi
}

function ad()
{
    ack $* -G "\.d$"
}

function ac()
{
    ack $* -G "\.(c|h|cxx|cpp)$"
}

function pcp()
{
    rsync -rvh --progress $*
}

[ -f ~/.project ] && source ~/.project
