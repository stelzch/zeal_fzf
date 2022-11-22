#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
docset=$1
if [[ -z $docset ]]; then
    docsets=$(
    ls ~/.local/share/Zeal/Zeal/docsets \
        | grep -ioP ".*(?=.docset)" | tr '\n' ' ')
    echo -e "Must supply docset as parameter.\nAvailable docsets: $docsets"
    exit -1
fi

prefix="$HOME/.local/share/Zeal/Zeal/docsets/$docset.docset/Contents/Resources/Documents"
if [[ ! -d "$prefix" ]]; then
    echo Could not find docset $docset
    exit -1
fi
url=$(echo "" | \
fzf \
    --bind "change:reload('$SCRIPT_DIR/zeal_query.sh' $1 '{q}')" \
    --delimiter=";" \
    --with-nth=1 \
    --disabled |  \
    grep -oP ';(.*<dash_entry.*>)?\K.*'
)

if [[ -n $url ]]; then
    w3m $prefix/$url
else
    echo No result
    echo $url
    exit -1 
fi
