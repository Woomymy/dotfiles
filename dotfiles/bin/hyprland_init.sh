#!/usr/bin/env bash

# Source all env files
# /etc/profile resets path and should be sourced first
for PROFILE in /etc/profile "${HOME}/.profile"
do
    if [ -f "${PROFILE}" ]
    then
        source "${PROFILE}"
    fi
done

# Ensure all apps detect wayland properly
export XDG_SESSION_TYPE="wayland"
export SDL_VIDEODRIVER="wayland"
export _JAVA_AWT_WM_NONREPARENTING=1
export QT_QPA_PLATFORM=wayland
export XDG_CURRENT_DESKTOP=Hyprland
export XDG_SESSION_DESKTOP=Hyprland

# Create XDG runtime dir if it doesn't exist
export XDG_RUNTIME_DIR="/run/user/$(id -u)"

if [[ ! -d "${XDG_RUNTIME_DIR}" ]]
then
    mkdir "${XDG_RUNTIME_DIR}"
    chmod 0700 "${XDG_RUNTIME_DIR}"
fi


# Start sway
exec dbus-launch --exit-with-session Hyprland

