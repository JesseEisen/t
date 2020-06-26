#!/usr/bin/env bash

[ $# -ge 1 -a -f "$2" ] && input="$2" || input="-"

function usage() {
    local command="t-upper"
    cat << EOS

Usage:
    ${command} <option> [params] [filename]
    
    options:
        --linefirst    upper first character of each line
        --wordfirst    upper first character of each word

Examples:
    
    Upper line first chaacter:
        ${command} --linefirst filename
        cat filename | ${command} --linefirst

EOS
}

function linefirst() {
    cat "$1" | awk '{$1=toupper(substr($1,1,1)) substr($1,2)}1'
}

function wordfirst() {
    cat "$1" | awk '{for(i=1;i<=NF;i++){ $i=toupper(substr($i,1,1)) substr($i,2) }}1'
}

case "$1" in
    --linefirst)
        linefirst "$input"
        ;;
    --wordfirst)
        wordfirst "$input"
        ;;
    *)
        usage
esac
