# curlai--discover-service

<a href="https://heroku.com/deploy?template=https://github.com/a6b8/curlai--discover-service?env[MULTIPLICATOR]=42">
  <img src="https://www.herokucdn.com/deploy/button.svg" alt="Deploy">
</a>


## docker-compose

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

## request
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
