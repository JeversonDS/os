#!/bin/bash

xdotool mousemove 1919 1079
dir=~/Videos/Gravações
resolucao=$(xdpyinfo | grep dimensions | awk '{print $2}')
filename="record-$(date +%Y%m%d_%H%M%S).mkv"
mkdir -p "$dir"
ffmpeg -f x11grab -video_size $resolucao -i :0.0 -f pulse -ac 2 -i default -c:v libx264 -preset slow -crf 18 -c:a aac -b:a 192k "$dir/$filename"