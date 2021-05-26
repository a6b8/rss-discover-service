# RSS Discover Service

## Quickstart
1. Create your Heroku Instance<br>
<a href="https://heroku.com/deploy?template=https://github.com/a6b8/curlai--discover-service?env[MULTIPLICATOR]=42">
  <img src="https://www.herokucdn.com/deploy/button.svg" alt="Deploy">
</a>
1. ```curl``` for an result


## Routes
| Nr | Type | Route | Expect | Return |
| --- | --- | --- |  --- |  --- | 
| 1 | yt | /discover/yt/watch | Video ID | Channel ID, RSS Feed | 

## Access



## Response

1. yt
```json
{
    "video": {
        "id": "VIDEO_ID",
    },
    "channel": {
        "id": "CHANNEL_ID",
        "name": "CHANNEL_NAME"
    },
    "rss": {
      "url": "RSS_URL"
    }
}
```
