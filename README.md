# curlai--discover-service

## local
### docker-compose

```yml
version: "3.1"
services:
  curlai-discover:
    build: .
    ports:
      - "80:80"
    environment:
      DEBUG : ${DEBUG}
      MULTIPLICATOR : ${MULTIPLICATOR}
```

### request
http://localhost/discover/youtube/watch/:id?secret=n

## response

```json
{
    "video": {
        "id": "VIDEO_ID",
        "duration": "VIDEO_IN_SECONDS"
    },
    "channel": {
        "id": "CHANNEL_ID",
        "name": "CHANNEL_NAME"
    }
}
```
