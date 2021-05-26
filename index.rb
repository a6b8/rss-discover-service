require 'rubygems'
require 'bundler'
Bundler.require

require 'net/http'
require 'sinatra/base'
require 'active_support/core_ext/hash/indifferent_access'

require './discover/yt/watch.rb'
require './discover/access/access.rb'


class Discover < Sinatra::Base
    set :bind, '0.0.0.0'
    set :port, '80'
    set :views, './templates'

    secrets = set_secrets()
    get '/discover/yt/watch/:video_id' do
        access = access_check( secrets[:multiplicator], params[ 'access' ], secrets[:debug] )
        if access
            video = yt_video_to_channel( params[ 'video_id' ], secrets[:debug] )
            status 200
            content_type :json
            JSON.pretty_generate( video )
        else
            status 404
            erb :error, :locals => { :secret => params[ 'secret' ] }
        end
    end

    get '/*' do
        status 404
        erb :hello
    end
end


