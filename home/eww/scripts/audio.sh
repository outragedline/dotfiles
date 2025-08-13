#!/bin/bash

get_audio_status() {
  vol=$(pamixer --get-volume)
  sink_muted=$(pamixer --get-mute)
  source_muted=$(pamixer --default-source --get-mute)

  if [ "$sink_muted" = "true" ]; then
    vol_icon="󰖁"
  elif [ "$vol" -gt 66 ]; then
    vol_icon="󰕾"
  elif [ "$vol" -gt 33 ]; then
    vol_icon="󰖀"
  else
    vol_icon="󰕿"
  fi

  if [ "$source_muted" = "true" ]; then
    source_icon=""
  else
    source_icon=""
  fi

printf '{"volume":%s,"vol_icon":"%s","source_icon":"%s"}\n' \
    "$vol" "$vol_icon" "$source_icon"
}

get_audio_status

pw-mon | grep --line-buffered "sink\|source" | while read -r _; do
  get_audio_status
done
