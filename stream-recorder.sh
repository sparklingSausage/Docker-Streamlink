#!/bin/bash

STREAM_QUALITY="${STREAM_QUALITY:-best}"
OUTPUT_DIR="${OUTPUT_DIR:-/recordings}"
CHECK_INTERVAL="${CHECK_INTERVAL:-30}"
STREAMLINK_ARGS="${STREAMLINK_ARGS:---twitch-disable-ads}"

if [ -z "$STREAMERS" ]; then
    echo "Error: STREAMERS environment variable not set. Please supply a comma separated list of streamers."
    exit 1
fi

IFS=',' read -ra STREAMER_LIST <<< "$STREAMERS"

mkdir -p "$OUTPUT_DIR"

record_streamer() {
    local streamer="$1"
    local out_dir="${OUTPUT_DIR}/${streamer}"
    mkdir -p "$out_dir"

    echo "Starting monitor for $streamer..."

    while true; do
        if streamlink --json "twitch.tv/$streamer" "$STREAM_QUALITY" &>/dev/null; then
            TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
            echo "[$streamer] Live at $TIMESTAMP, starting recording..."
            streamlink $STREAMLINK_ARGS "twitch.tv/$streamer" "$STREAM_QUALITY" \
                -o "${out_dir}/${streamer}-${TIMESTAMP}.mp4" \
                >> "${out_dir}/record.log" 2>&1
            echo "[$streamer] Stream ended at $(date)"
        else
            echo "[$streamer] Offline at $(date)"
        fi

        sleep "$CHECK_INTERVAL"
    done
}

for streamer in "${STREAMER_LIST[@]}"; do
    # Skip empty entries (in case of malformed STREAMERS value)
    [[ -z "$streamer" ]] && continue
    record_streamer "$streamer" &
done

wait

