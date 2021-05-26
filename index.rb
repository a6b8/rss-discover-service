require 'rubygems'
require 'bundler'
Bundler.require

require 'net/http'
require 'sinatra/base'
require 'active_support/core_ext/hash/indifferent_access'

require './discover/youtube/watch.rb'

class Discover < Sinatra::Base
    def self.set_secrets()
        result = {}

        keys = [
            'DEBUG',
            'MULTIPLICATOR'
        ]

        keys.each do | key |
            case key
                when "DEBUG"
                    result[:debug] = JSON.parse( ENV[ key ] )
                when "MULTIPLICATOR"
                    result[:multiplicator] = ENV[ key ].to_i
                else
            end
        end

        return result
    end


    def self.access_check( multiplicator, answer, debug )
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

    secrets = Discover.set_secrets()
    secrets = {
        debug: true
    }

    get '/discover/youtube/watch/:id' do
        access = Discover.access_check( secrets[:multiplicator], params[ 'secret' ], secrets[:debug] )
        if access
            video = youtube_video_to_channel( params[ 'id' ], secrets[:debug] )
            content_type :json
            video.to_json
        else
            "Access Denied! #{params[ 'secret' ]}"
        end
    end

    get '/*' do
        'Welcome'
    end
end
