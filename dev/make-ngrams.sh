#!/bin/bash

set -e -u

if [[ -z ${TMPDIR:-} ]];then
    echo "Putting temporary files in $(pwd)/tmp/ ..."
    test -d tmp || mkdir tmp
    export TMPDIR="$(pwd)"/tmp
    trap "rmdir \"$TMPDIR\"" EXIT
    # for sort, assumes current disk has more space than /tmp
fi

corp () {
    "$@" | tr -s ' ' '\n'
}

hitparade () {
    export LC_ALL=C
    sort | uniq -c | sort -nr | sed $'s/^ *//;s/ /\t/' | head -10000
}

if [[ $# -eq 0 ]]; then
    echo "" >&2
    echo "Error: Expecting some command that cats a corpus as argument(s)" >&2
    echo "For example:" >&2
    echo "$ $0 xzcat ~/corpora/nno.corp.xz" >&2
    echo "" >&2
    echo "Will create files ngrams.[1-5]" >&2
    exit 1
fi

test -f ngrams.1 || paste <(corp "$@") | hitparade >ngrams.1
test -f ngrams.2 || paste <(corp "$@") <(corp "$@"|tail -n+2) | hitparade >ngrams.2
test -f ngrams.3 || paste <(corp "$@") <(corp "$@"|tail -n+2) <(corp "$@"|tail -n+3) | hitparade >ngrams.3
test -f ngrams.4 || paste <(corp "$@") <(corp "$@"|tail -n+2) <(corp "$@"|tail -n+3) <(corp "$@"|tail -n+4) | hitparade >ngrams.4
test -f ngrams.5 || paste <(corp "$@") <(corp "$@"|tail -n+2) <(corp "$@"|tail -n+3) <(corp "$@"|tail -n+4) <(corp "$@"|tail -n+5) | hitparade >ngrams.5

