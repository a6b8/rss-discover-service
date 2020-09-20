def youtube_video_to_channel( video_id, debug )
  def download_html( url, debug )
    uri = URI( url )
    res = Net::HTTP.get( uri ) 
    html = Nokogiri::HTML( res )
    return html
  end

  def download_xml( url, debug )
    uri = URI( url )
    res = Net::HTTP.get( uri ) 
    xml = Nokogiri::XML( res )
    return xml
  end

  item = {
    :video => {
      :id => video_id,
      :duration => nil
    },
    :channel => {
      :id => nil,
      :name => nil
    }
  }
  
  sources = { :embed => 'https://www.youtube.com/embed/' }

  url = ''
  url += sources[:embed]
  url += item[:video][:id]

  html = download_html( url, debug )

  scripts = html.xpath( '/html/body/script[1]' ).text.split( ';' )
  scripts.each { | script | 
    if !script.index( 'channelId' ).nil?
      item[:channel][:id] = script[ script.index( 'channelId' ) + 14, 24 ]
    end
    
    if !script.index( 'videoDurationSeconds' ).nil?
      f = script[ script.index( 'videoDurationSeconds' )-1, 300 ]
      f = f.split(',')[ 0 ]
      f = f.gsub('\"', '"')
      item[:video][:duration] = /(?:"videoDurationSeconds":")(.*?)(?:")/.match( f )[ 1 ]
    end
  }

  if !item[:channel][:id].nil?
    puts feed = 'https://www.youtube.com/feeds/videos.xml?channel_id=' + item[:channel][:id]
    xml = download_xml( feed, debug )
    item[:channel][:name] = xml.at( 'feed' ).css( 'title' )[ 0 ].text
  end

  return item
end