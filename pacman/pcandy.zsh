#!/bin/zsh

hmsg="usage:
    pcandy [ -h ] [ -i | -f | -a ] search_term

options:
    -i, --installed     list only installed packages
    -f, --finstalled    list only installed and foreign packages
    -a, --aur           use auracle for search and info
    search_term         the term to search for
"

help () {
    printf '%s' "$hmsg"
}

display () {
    preview='pacman --color=always -Si {}'
    printf '%s' "$2" | fzf --preview "$1" --layout=reverse --bind "enter:execute(${1} | less -R)"
}

installed () {
    if [[ $# -lt 1 ]]; then
        pkgs="$(pacman -Qq)"
    else
        q="$1"
        pkgs="$(pacman -Qsq -- "$q")"
    fi
    display 'pacman --color=always -Qil {}' "$pkgs"
}

finstalled () {
    if [[ $# -lt 1 ]]; then
        pkgs="$(pacman -Qmq)"
    else
        printf '%s\n' 'error: cannot search foreign packages'
        exit 1
    fi
    display 'pacman --color=always -Qil {}' "$pkgs"
}

aur () {
    if [[ $# -lt 1 ]]; then
        printf '%s\n' 'error: need search term for auracle'
        exit 1
    else
        q="$1"
        display \
            'printf '"'"'%s\n\n'"'"' "$(auracle --color=always info {})" "$(auracle --color=always show {})"' \
            "$(auracle -q search -- "$q")"
    fi
}

default () {
    if [[ $# -lt 1 ]]; then
        pkgs="$(pacman -Slq)"
    else
        q="$1"
        pkgs="$(pacman -Ssq -- "$q")"
    fi
    display 'pacman --color=always -Si {}' "$pkgs"
}

if [[ "$1" = "-i" || "$1" = "--installed" ]]; then
    shift
    installed $@
elif [[ "$1" = "-f" || "$1" = "--finstalled" ]]; then
    shift
    finstalled $@
elif [[ "$1" = "-a" || "$1" = "--aur" ]]; then
    shift
    aur $@
elif [[ "$1" = "-h" || "$1" = "--help" ]]; then
    help
else
    default $@
fi

exit 0
