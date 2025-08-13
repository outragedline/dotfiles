#!/bin/bash

get_brightness() {
  bri=$(brightnessctl get)
  max=$(brightnessctl max)
  percent=$((bri * 100 / max))

  if [ "$percent" -gt 66 ]; then
    icon="󰃠"
  elif [ "$percent" -gt 33 ]; then
    icon="󰃟"
  else
    icon="󰃞"
  fi

    printf '{"percent":"%s","icon":"%s"}\n' \
      "$percent" "$icon"
}

get_brightness

inotifywait -m -e modify /sys/class/backlight/*/brightness --format "" |
while read -r; do
  get_brightness
done
