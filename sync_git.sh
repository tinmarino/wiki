#!/bin/bash
# This file serves for synchronosation

current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
# Sychrnonize argument folder
function ssync(){
    title=$(basename -- "$1")
    title=${title^^}
    echo "--->  $title  ================================================="
    mkdir $1
    pushd $1 > /dev/null
    git add .
    git commit -m "___ <- sync_git.sh"
    git pull --rebase
    git push
    popd > /dev/null
}

echo "---> Synchronizing from internet"


ssync ~/.vim
ssync $current_dir
ssync ../wiki_html
ssync ../todo
ssync ../html


echo "<--- Synchronization finihed"
