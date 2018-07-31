#!/bin/bash
# This file serves for synchronosation

current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
# Sychrnonize argument folder
function ssync(){
    title=$(basename -- "$1")
    title=${title^^}
    echo "--->  $title  ================================================="
    pushd $1 > /dev/null
    git pull --rebase
    git push
    popd > /dev/null
}

echo "---> Synchronizing from internet"


ssync ~/.vim
ssync $current_dir
ssync ../wiki_html
ssync ../todo


echo "<--- Synchronization finihed"
