# RSS Discover Service

## Quickstart
1. Create your Heroku Instance<br>
<a href="https://heroku.com/deploy?template=https://github.com/a6b8/curlai--discover-service">
  <img src="https://www.herokucdn.com/deploy/button.svg" alt="Deploy">
</a><br>
1. Setup Enironment Variables<br>
   ```MULTIPLICATOR : [Int]```<br>
   ```DEBUG : [boolean]```<br>
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

**1. Copy into Spreadsheet**
| A | B | C | D | E | F | G |
|---|---|---|---|---|---|---|
| **Multiplicator:** | 42  |
| **Date:** | =NOW()  |
| **Date Copy:** | Copy Date: Right Mouse Click -> Values Only]  |
| **API:** | https://api.example.com/discover/yt/watch |
|  |  |  | 2 | 3 | 4 | 5 | 
| NR | VIDEO URL | REQUEST | VIDEO ID |	CHANNEL ID | CHANNEL NAME | RSS URL |
| =IF(A6="NR",1,A6+1) | [YOUR VIDEO URL] | =CONCATENATE( $B$4,"/",INDEX( SPLIT( B7,"?v=","" ), 2 ),"?","secret=", FLOOR( ( YEAR( $B$3 ) - MONTH( $B$3 ) + DAY( $B$3 ) ) * $B$1 ) ) | =INDEX( ImportJSON( B7 ), 2 ) | | | | |
