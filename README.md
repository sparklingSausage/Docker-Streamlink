## Info
This is a Docker container which uses streamlink in a python container to record streams from twitch.tv.

From my testing each streamer uses round about 1MB/s so for example: 5 streamers = 5MB/S
### WARNING!!
Might be cpu-heavy depending on how many streamers you're recording at once

### Install
1. Download all files and move them into one folder so it looks something like this:
```
<your-folder-name>
├── docker-compose.yml
├── Dockerfile
├── streamers.txt
└── streamlink-recorder.sh
```
2. Edit the docker-compose.yml file and adjust the paths
3. Add Streamers inside Streamers.txt
4. Run
```
docker build -t <INSERT-NAME> .
```
6. you're ready to go
