#!/usr/bin/env bash

set -euo pipefail

SCH="${1}"
OUT="${HOME}/.config/rofi/scheme.rasi"
touch $OUT
# Redirect all our stdout
exec 1>$OUT

echo "* {"
jq -r ". | to_entries | .[].key" "${SCH}" | while read key; do
    # Don't inform rofi about scheme type
    if [[ "${key}" != "type" ]]
    then
        echo "    ${key}: $(jq -r ".${key}" "${SCH}");"
    fi
done
echo "}"

