#!/bin/bash

IFS=';' read -r -a args <<< "$1"
streamQuality="$2"
streamerListFile="$3"
outputPath="$4"

outputPath="${outputPath:-/home/download}"

mkdir -p "$outputPath"

if [[ ! -f "$streamerListFile" ]]; then
  echo "Streamer list file not found: $streamerListFile"
  exit 1
fi

while true; do
    mapfile -t streamers < "$streamerListFile"

    for streamer in "${streamers[@]}"; do
        [[ -z "$streamer" ]] && continue

	Date=$(date +%Y%m%d-%H%M%S)
	streamerFolder="${outputPath}/${streamer}"

	mkdir -p "$streamerFolder"
	echo "Starting download for $streamer at $Date"

	streamlink "${args[@]}" "twitch.tv/$streamer" "$streamQuality" \
	    -o "${streamerFolder}/${streamer}-${Date}.mp4" &

    done

    wait
    sleep 60s
done
