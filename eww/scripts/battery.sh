#/bin/bash

capacity=$(cat /sys/class/power_supply/BAT0/capacity)
online=$(cat /sys/class/power_supply/AC0/online)

if [[ "$online" == "1" ]]; then
    icon=""
else
    case $capacity in
        100|9[0-9]) icon="󰁹" ;;
        8[0-9]) icon="󰂂" ;;
        7[0-9]) icon="󰂁" ;;
        6[0-9]) icon="󰂀" ;;
        5[0-9]) icon="󰁿" ;;
        4[0-9]) icon="󰁾" ;;
        3[0-9]) icon="󰁽" ;;
        2[0-9]) icon="󰁼" ;;
        1[0-9]) icon="󰁻" ;;
        *) icon="IM GONNA DIE" ;;
    esac
fi

printf '{"capacity": %d, "icon": "%s"}\n' "$capacity" "$icon"
