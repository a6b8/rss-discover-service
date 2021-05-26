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
  
  def parse_params( html )
    select = {
      script: {
        xpath: '//script',
        selector: 'var ytcfg'
      },
      params: {
        from: {
          gsub: "ytcfg.set(",
          index: nil
        },
        to: {
          gsub: '});',
          index: nil
        }    
      }
    }

    scripts = html.xpath( select[:script][:xpath] )
    script = scripts.find { | s | s.text.start_with?( select[:script][:selector] ) }

    tmp = script.text
    select[:params][:from][:index] = tmp.index( select[:params][:from][:gsub] )
    tmp = tmp[ select[:params][:from][:index] + select[:params][:from][:gsub].length, tmp.length]
    select[:params][:to][:index] = tmp.index( select[:params][:to][:gsub] )
    tmp = tmp[ 0, select[:params][:to][:index] ]
    tmp << select[:params][:to][:gsub][ 0, 1 ]
    params = JSON.parse( tmp )
    data = { :data => params }
    data = data.with_indifferent_access
    data[:data][:PLAYER_VARS][:embedded_player_response] = JSON.parse( data[:data][:PLAYER_VARS][:embedded_player_response] )
    data = data.with_indifferent_access
    return data
  end
  
  def parse_channel_id( data, keys )
    tmp = {}    
    tmp = data[:data]
    keys.each { | key | tmp = tmp[ key ]}
    channel_id = tmp
    return channel_id
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
  data = parse_params( html )
  
  
  keys = [
    :PLAYER_VARS,
    :embedded_player_response,
    :embedPreview,
    :thumbnailPreviewRenderer,
    :videoDetails,
    :embeddedPlayerOverlayVideoDetailsRenderer,
    :expandedRenderer,
    :embeddedPlayerOverlayVideoDetailsExpandedRenderer,
    :subscribeButton,
    :subscribeButtonRenderer,
    :channelId
  ]
  
  item[:channel][:id] = parse_channel_id( data, keys )
  
  if !item[:channel][:id].nil?
    puts feed = 'https://www.youtube.com/feeds/videos.xml?channel_id=' + item[:channel][:id]
    xml = download_xml( feed, debug )
    item[:channel][:name] = xml.at( 'feed' ).css( 'title' )[ 0 ].text
  end

  return item
end