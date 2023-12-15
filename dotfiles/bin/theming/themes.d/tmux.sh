#!/usr/bin/env bash

set -euo pipefail

SCH="${2}"
DEST="${HOME}/.tmux.scheme"

echo "" > "${DEST}"

jq -r ". | to_entries | .[].key" "${SCH}" | while read key; do
    echo "set -g @$key \"$(jq -r ".${key}" "${SCH}")\"" >> "${DEST}"
done

# For some reason TMUX needs to be sourced 2 times
tmux -S "/tmp/tmux-$(id -u)/default" source-file "${HOME}/.tmux.conf" || true
tmux -S "/tmp/tmux-$(id -u)/default" source-file "${HOME}/.tmux.conf" || true

