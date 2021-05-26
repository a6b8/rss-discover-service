hash = {
    server: {
        used: nil,
        route: 'discover/yt/watch/'
    },
    video_id: {
        default: 'eksctYclLEA',
        used: nil
    },
    multiplicator: {
        default: 42,
        used: nil
    }
}


puts 
puts 'DISCOVER TEST - Video'
puts '----------------------------'
puts ''

puts 'SERVER (Example: https://api.example.com)'
print '>>  '
input = gets.chomp
if input.eql? ''
    exit
else
    hash[:server][:used] = input.strip!
end

puts 'VIDEO ID (Default: ' + hash[:video_id][:default] + ')'
print '>>  '
input = gets.chomp
if input.eql? ''
    hash[:video_id][:used] = hash[:video_id][:default]
else
    hash[:video_id][:used] = input
end

puts 'MULTIPLICATOR (Default ' + hash[:multiplicator][:default].to_s + ')'
print '>>  '
input = gets.chomp
if input.eql? ''
    hash[:multiplicator][:used] = hash[:multiplicator][:default]
else
    hash[:multiplicator][:used] = input.to_i
end


require 'uri'
require 'net/http'
require 'json'

y = Time.now.year.to_i
m = Time.now.month.to_i
d = Time.now.day.to_i
access = ( ( y - m + d ) * hash[:multiplicator][:used] ).floor

url = ''
url << hash[:server][:used]
url << '/'
url << hash[:server][:route]
url << '/'
url << hash[:video_id][:used]
url << '?access='
url << access.to_s

uri = URI.parse( url )
http = Net::HTTP.new( uri.host, uri.port )
http.use_ssl = true

request = Net::HTTP::Get.new(uri.request_uri)
res = http.request(request)

puts ''
puts 'URL: ' + url
if res.code.to_s.eql? '200'
    puts 'OK'
    puts JSON.pretty_generate( request.to_s )
else
    puts 'Error'
    puts res.code.to_s
end
exit