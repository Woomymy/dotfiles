#!/usr/bin/env bash

# Wait for color scheme generation before starting waybar
while ! test -f /tmp/waybar-colors.css
do
    sleep 0.5
done

exec waybar

