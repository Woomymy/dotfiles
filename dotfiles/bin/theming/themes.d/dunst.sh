#!/usr/bin/env bash

set -euo pipefail

SCH="${1}"
DEST="${HOME}/.config/dunst/dunstrc"
TLP="${DEST}.template"

cp "${TLP}" "${DEST}"

jq -r ". | to_entries | .[].key" "${SCH}" | while read key; do
    sed -i "s/{${key}}/$(jq -r ".${key}" "${SCH}")/gim" "${DEST}"
done

pkill dunst || true # Kill dunst to make sure it reloads colors

