#!/usr/bin/env bash

set -e

prev_dir="$PWD"
cd "$(dirname "${BASH_SOURCE[0]}")/.."

declare -a progs=("pass-open-doc")

for prog in "${progs[@]}";
do
    ./argbash/bin/argbash "./bash_templates/$prog.in.sh" -o "$prog"
done

cd "$prev_dir"
