#!/usr/bin/env bash

set -eo pipefail

FILE="$(mktemp -u)"
TEXT="$(lsb_release -d | awk -F ":	" '{print $2}')"

# Turns on the screens
ddc_poweron() {
    for SCREEN in ${1}
    do
        ddcutil setvcp D6 1 --bus="${SCREEN}" || true
    done
}

# Turns off the screens
ddc_poweroff() {
    for SCREEN in ${1}
    do
        ddcutil setvcp D6 4 --bus="${SCREEN}" || true
    done
}

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
    SCREENS="$(jq -r ".i2c_displays[]" "${HOME}/.bin/config.json")"
    WALLPAPER="$(ls /tmp/wallpaper-*.jpg)"
    cp "${WALLPAPER}" "${FILE}"
	apply_blur "${FILE}"
	add_text "${FILE}"
    
    if [[ "${1}" == "--suspend" ]]
    then
        ddc_poweroff "${SCREENS}"
        swaylock -i "${FILE}" &
        systemctl suspend
        # Systemctl suspend is asynchronous
        # This is not the best solution and it probably needs to be fixed
        sleep 2
        ddc_poweron "${SCREENS}"
    else
        [[ "${1}" == "--screenoff" ]] && ddc_poweroff "${SCREENS}"
        pulsemixer --toggle-mute
        swaylock -i "${FILE}"
        pulsemixer --toggle-mute
        [[ "${1}" == "--screenoff" ]] && ddc_poweron "${SCREENS}"
    fi

    rm "${FILE}"
}

main "${1}" || {
	notify-send -u "critical" "Failed to lock"
}
