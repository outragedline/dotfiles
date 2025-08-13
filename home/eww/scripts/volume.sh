#!/bin/bash
 
case $1 in
  up)
    pamixer -i 1
    ;;
  down)
    pamixer -d 1
    ;;
esac
