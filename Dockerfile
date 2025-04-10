FROM python:3.11-slim

RUN pip install streamlink

WORKDIR /app

COPY streamlink-recorder.sh .
RUN chmod +x streamlink-recorder.sh

RUN mkdir -p /home/download

CMD ["./streamlink-recorder.sh", "--twitch-disable-ads", "best", "/app/streamers.txt", "/home/download"]
