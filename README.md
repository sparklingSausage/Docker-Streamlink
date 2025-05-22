## Docker-streamlink
This image is made to record multiple Twitch streamers at once

## Info
- might be CPU and NETWORK heavy
- each streamer uses ~1MB/s

## Installation
- Docker compose

```
  twitch-recorder:
    image: latenightweeb/streamlink-recorder
    container_name: twitch_recorder
    restart: unless-stopped
    environment:
      STREAMERS: bastighg,letshugotv,lydiaviolet,papaplatte,themewdew
      OUTPUT_DIR: /recordings
      STREAM_QUALITY: best
      CHECK_INTERVAL: 60
      STREAMLINK_ARGS: --twitch-disable-ads
    volumes:
      - /media/pi/4TB/stream/:/recordings
```

- Build it manually using the [stream-recorder.sh](stream-recorder.sh) and [Dockerfile](Dockerfile)

## ⚠️ Disclaimer

This project is provided for educational and personal use only.
I do not condone or support the use of this tool for violating Twitch's Terms of Service, copyright laws, or any other applicable rules.

By using this code, you take full responsibility for how you use it.
The creator of this project are not liable for any misuse or legal issues that may arise.
