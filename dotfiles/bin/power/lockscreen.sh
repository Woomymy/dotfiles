#!/usr/bin/env bash

set -euo pipefail

FILE="$(mktemp -u)"
TEXT="$(lsb_release -d | awk -F ":	" '{print $2}')"

# Usage: apply_blur FILE
apply_blur()
{
	# Temporary file used for conversion
	TMP_FILE="$(mktemp -u)"	
	SCREENSHOT="${1}"
	
	convert "${SCREENSHOT}" -filter Gaussian -blur 0x8 "${TMP_FILE}"
	mv "${TMP_FILE}" "${SCREENSHOT}"
}

add_text()
{
	TMP_FILE="$(mktemp -u)"
	SCREENSHOT="${1}"
	convert -pointsize 72 -fill white -draw "text 50,1000 '${TEXT}'" "${SCREENSHOT}" "${TMP_FILE}"
	mv "${TMP_FILE}" "${SCREENSHOT}"
}

main()
{
    WALLPAPER="$(ls /tmp/wallpaper-*.jpg)"
    cp "${WALLPAPER}" "${FILE}"
	apply_blur "${FILE}"
	add_text "${FILE}"
    
    pulsemixer --toggle-mute
    swaylock -i "${FILE}"
    pulsemixer --toggle-mute
    rm "${FILE}"

}

main || {
	notify-send -u "critical" "Failed to lock"
}
