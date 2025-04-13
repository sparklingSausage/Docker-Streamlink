# Dockerfile
FROM python:3.11-slim

RUN apt-get update && \
    apt-get install -y ffmpeg curl && \
    pip install streamlink && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY stream-recorder.sh .
COPY streamers.txt .

RUN chmod +x stream-recorder.sh

CMD ["./stream-recorder.sh"]
