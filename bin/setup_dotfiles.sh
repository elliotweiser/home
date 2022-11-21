#!/bin/bash

repo=$(git rev-parse --show-toplevel 2> /dev/null)
for item in $(find "${repo}/dotfiles" -type f -name '.*'); do
    echo "cat ${item} > ${HOME}/$(basename ${item})"
    cat ${item} > ${HOME}/$(basename ${item})
done
