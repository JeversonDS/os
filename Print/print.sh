#!/bin/bash

xdotool mousemove 1919 1079
dir=~/Pictures/Screenshots/
resolucao=$(xdpyinfo | grep dimensions | awk '{print $2}')
filename="screenshots-$(date +%Y%m%d_%H%M%S).png"
mkdir -p "$dir"
ffmpeg -f x11grab -video_size $resolucao -i :0.0 -vframes 1 -q:v 1 "$dir/$filename"