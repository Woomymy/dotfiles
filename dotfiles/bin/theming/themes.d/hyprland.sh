#!/usr/bin/env bash

set -euo pipefail

SCH="${1}"

get_color() {
    COLOR="$(jq -r ".${1}" "${SCH}")"
    echo "rgb(${COLOR//#/})"
}

cat << EOF > /tmp/hyprland-colors.conf
general {
    col.active_border=$(get_color "primary")
    col.inactive_border=$(get_color "outline")
}
EOF

hyprctl reload

