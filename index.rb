require 'rubygems'
require 'bundler'
Bundler.require

require 'net/http'
require 'sinatra/base'
require 'active_support/core_ext/hash/indifferent_access'

require './discover/youtube/watch.rb'
require './discover/access/access.rb'
#

class Discover < Sinatra::Base
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

    get '/*' do
        'Welcome'
    end
end
