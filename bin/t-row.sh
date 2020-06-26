#!/usr/bin/env bash

[ $# -ge 1 -a -f "$2" ] && input="$2" || input="-"

function usage() {
    local command="t-row"
    cat << EOS

Usage:
    ${command} <odd|even|line|range> [params] [filename]

Examples:
    Output the odd row of file:
        ${command} odd filename
        cat a.txt | ${command} even 

    Output specify line of the input
        ${command} line filename 10
        cat filename | ${command} line 10

    Output sepcify range of input
        ${command} range filename 10 14
        cat filename | ${command} range 10 14

EOS
}

function even() {
    cat "$1" | sed -n 'n;p'
}

function odd() {
    cat "$1" | sed -n 'p;n'
}

function line() {
    echo
    cat "$1" | sed -n "$2p"
    echo
}

function range() {
    echo
    cat "$1" | sed -n "$2,$3p"
    echo
}


case "$1" in
    odd)
        odd "$input"
        ;;
    even)
        even "$input"
        ;;
    line)
        line "$input" "$3"
        ;;
    range)
        (test $# = 3 && range "$input" "$2" "$3") || (test $# = 4 && range "$input" "$3" "$4")
        ;;
    *)
        usage
esac        
