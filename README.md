# curlai--discover-service

## request
https://localhost/discover/youtube/watch/:id?secret=n

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
