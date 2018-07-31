#!/bin/bash
# This file serves for synchronosation


current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

echo "---> Synchronizing from internet"
echo "---> Wiki ================================================"
cd $current_dir
git pull --rebase

echo "---> Wiki HTML ==========================================="
cd ../wiki_html
git pull --rebase

echo "---> Todo ================================================"
cd ../todo
git pull --rebase


echo "<--- Synchronization finihed"
