# require 'sinatra'
# require 'net/http'
# require 'nokogiri'
# require 'active_support/core_ext/hash/indifferent_access'
# require 'json'
# require './helpers/youtube/watch.rb'
#require 'active_support/core_ext/hash/indifferent_access'

require 'rubygems'
require 'bundler'
Bundler.require

require 'net/http'
require './discover/youtube/watch.rb'


def set_secrets()
    obj = {}

    for i in 0 ... ARGV.length
        puts ARGV[ i ].to_s
        key = ARGV[ i ].split( "=" )[ 0 ]
        value = ARGV[ i ].split( "=" )[ 1 ].gsub( '"','' )

        if key.include? "_FILE"
            value = File.read( value )
            key = key[ 0, key.length - 5 ]
        end

        case key
            when "DEBUG"
                puts value
                obj[:debug] = JSON.parse( value )
            when "MULTIPLICATOR"
                puts value
                obj[:multiplicator] = value.to_i
            else
        end
        puts obj
        puts '----'
    end
    return obj
end


def access_check( multiplicator, answer, debug )
    y = Time.now.year.to_i
    m = Time.now.month.to_i
    d = Time.now.day.to_i

    sum = ( ( y - m + d ) * multiplicator.to_i ).floor
    debug ? puts( 'multiplicator: ' + multiplicator.to_s ) : ''
    debug ? puts( 'sum: ' + sum.to_s ) : ''
    debug ? puts( 'answer: ' + answer.to_s ) : ''
  
    result = false
    answer.to_i == sum ? result = true : ''

    return result
end


set :bind, '0.0.0.0'
set :port, '80'

secrets = set_secrets()

get '/discover/youtube/watch/:id' do
    access = access_check( secrets[:multiplicator], params[ 'secret' ], secrets[:debug] )

    if access
        video = youtube_video_to_channel( params[ 'id' ], secrets[:debug] )
        content_type :json
        video.to_json
    else
        "Access Denied! #{params[ 'secret' ]}"
    end
end


