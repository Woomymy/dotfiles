#!/usr/bin/env bash

set -euo pipefail

SCH="${1}"
OUT="/tmp/waybar-colors.css"
SCSS=""

touch $OUT

exec 1>$OUT
jq -r ". | to_entries | .[].key" "${SCH}" | while read key; do
    if [[ "${key}" != "type" ]]; then
        echo "@define-color ${key} $(jq -r ".${key}" "${SCH}");"
    fi
done

