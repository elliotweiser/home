#!/bin/bash

repo=$(git rev-parse --show-toplevel 2> /dev/null)
if [[ ! -z "${repo}" ]]; then
  dotfiles=$(git ls-files --directory "${repo}/files" | sed 's/^files\///g')
fi
for item in ${dotfiles}; do
  /bin/ln -sf "${repo}/files/${item}" "${HOME}/${item}"
done
