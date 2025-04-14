FROM python:3.11-slim
RUN pip install streamlink && \
    apt-get update && \
    apt-get install -y ffmpeg && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV OUTPUT_DIR=/recordings
RUN mkdir -p ${OUTPUT_DIR}

COPY stream-recorder.sh /usr/local/bin/stream-recorder.sh
RUN chmod +x /usr/local/bin/stream-recorder.sh

ENTRYPOINT ["/usr/local/bin/stream-recorder.sh"]
