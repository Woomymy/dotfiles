#!/usr/bin/env bash

# Starts all services required by sway
user_services_start() {
    # Start user systemd services
    
    ## Import env
    systemctl --user import-environment SWAYSOCK PATH DBUS_SESSION_ADDRESS WAYLAND_DISPLAY DISPLAY XDG_SESSION_TYPE
    dbus-update-activation-environment 2>/dev/null && dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP

    ## Start base "SwaySession.target" to make user services start
    systemctl --user --no-block start SwaySession.target

    ## Setup wallpapers and themes.d theming
    python "${HOME}/.bin/theming/wallpapers.py" &
}

# Send all script output to systemd logs
exec > >(systemd-cat -t services_start) 2>&1

user_services_start

