#!/usr/bin/env bash

set -eo pipefail

DELETE="${1}"

DEST="${HOME}/Pictures/$(hostname)-screenshots"
[[ ! -d "${DEST}" ]] && mkdir "${DEST}"

IMAGE_NAME="screenshot-$(hostname)-$(date +%Y-%m-%d-%M_%m_%S).png"

# Paste the image th the clipboard if it contains an absolute path to a .png file
wl-paste -l | grep -i "image/png" || {
    IMG_PATH="$(wl-paste -n)"
    if [[ -f "${IMG_PATH}" ]] && [[ "$(file --mime-type "${IMG_PATH}" | awk -F ": " '{print $2}')" == "image/png" ]]; then
            wl-copy -t image/png < "${IMG_PATH}"
            notify-send "Screenshot" "Copied $(basename "${IMG_PATH}") to clipboard"
    fi

    exit
}

# Save the image
wl-paste -t image/png > "${DEST}/${IMAGE_NAME}"

echo -n "${DEST}/${IMAGE_NAME}" | wl-copy

if [[ "${DELETE}" != "true" ]]; then
    notify-send "Screenshot" "Saved ${IMAGE_NAME}"
else
    notify-send "Screenshot" "Saved ${IMAGE_NAME}. Deleting in 60s"
    sleep 60
    
    # if the image path is still in the clipboard, restore the png
    CLIPBOARD="$(wl-paste -n)"

    if [[ "${CLIPBOARD}" == "${DEST}/${IMAGE_NAME}" ]]; then
        wl-copy -t image/png < "${CLIPBOARD}"
        notify-send "Screenshot" "Deleted ${IMAGE_NAME} and copied it to clipboard"
    else
        notify-send "Screenshot" "Deleted ${IMAGE_NAME}"
    fi
    rm "${DEST}/${IMAGE_NAME}"
fi

