# RSS Discover Service

## Quickstart
1. Create your Heroku Instance<br>
<a href="https://heroku.com/deploy?template=https://github.com/a6b8/curlai--discover-service">
  <img src="https://www.herokucdn.com/deploy/button.svg" alt="Deploy">
</a>
1. Setup Enironment Variables<br>
   ```MULTIPLICATOR : [Int]```<br>
   ```DEBUG : [boolean]``` 
2. ```curl``` for an result


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

## Spreadsheet usage
Find RSS by Video URL

**1. Settings**
| | A | B |
|---|---|---|
| 1 | Multiplicator  | 42  |
| 2 | Date | =NOW()  |
| 3 | Date Copy | Copy Date: Right Mouse Click -> Values Only]  |
| 4 | API | https://api.example.com/discover/yt/watch |
| 5 | XML | https://yt.example.com/feeds/videos.xml?channel_id= | 


**2.Discover**
| | A | B | C | D | E | F | G |
|---|---|---|---|---|---|---|---|
| 8 |  |  |   |   |   |    |    | 
| 9 |  |  |  | 2 | 3 | 4 | 5 | 
| 10 | **NR**  | **URL** | **VIDEO ID**  | **CHANNEL ID**  | **CHANNEL NAME** | **RSS URL** | **VIDEO URL**   |    | 
| 11 | =IF(A10="NR",1,A10+1) | =CONCATENATE($A$4,"/",INDEX( SPLIT( H11,"?v=","" ), 2 ),"?","secret=", FLOOR( (YEAR( $B$3 ) - MONTH( $B$3 ) + DAY( $B$3 ) ) * $B$1 ) ) |   |   |   |    |    | 