#!/bin/bash

STREAM_QUALITY="best"
STREAMERS_FILE="streamers.txt"
OUTPUT_DIR="/recordings"
CHECK_INTERVAL=30  # per-streamer check frequency

mkdir -p "$OUTPUT_DIR"

# Function to monitor one streamer
record_streamer() {
    local streamer="$1"
    local out_dir="${OUTPUT_DIR}/${streamer}"
    mkdir -p "$out_dir"

    echo "Starting monitor for $streamer..."

    while true; do
        if streamlink --json "twitch.tv/$streamer" "$STREAM_QUALITY" &>/dev/null; then
            TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
            echo "[$streamer] Live at $TIMESTAMP, starting recording..."

            streamlink --twitch-disable-ads "twitch.tv/$streamer" "$STREAM_QUALITY" \
                -o "${out_dir}/${streamer}-${TIMESTAMP}.mp4" \
                >> "${out_dir}/record.log" 2>&1
            echo "[$streamer] Stream ended at $(date)"
        else
            echo "[$streamer] Offline at $(date)"
        fi

        sleep "$CHECK_INTERVAL"
    done
}

# Start one recording loop per streamer
while IFS= read -r streamer; do
    [[ -z "$streamer" ]] && continue
    record_streamer "$streamer" &
done < "$STREAMERS_FILE"

# Wait forever
wait
