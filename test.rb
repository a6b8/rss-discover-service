hash = {
    server: {
        used: nil,
        route: 'yt/watch/'
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
puts 'CHECK DISCOVER'
puts '----------------------------'
puts ''

puts 'SERVER (Example: https://api.example.com)'
print '>>  '
input = gets.chomp
if input.eql? ''
    exit
else
    hash[:server][:used] = input
end

puts 'VIDEO ID (Default: ' + hash[:video_id][:default] + ')'
print '>>  '
input = gets.chomp
if input.eql? ''
    hash[:video_id][:used] = hash[:video_id][:default]
else
    hash[:video_id][:used] = input
end

puts ''
puts 'MULTIPLICATOR (Default ' + hash[:multiplicator][:default] + ')'
print '>>  '
input = gets.chomp
if input.eql? ''
    hash[:params][:multiplicator] = hash[:multiplicator][:default]
ele
    hash[:params][:multiplicator] = input.to_i
end


y = Time.now.year.to_i
m = Time.now.month.to_i
d = Time.now.day.to_i
sum = ( ( y - m + d ) * hash[:params][:multiplicator] ).floor

url = ''
url << hash[:server][:used]
url << '/'

url << hash[:video_id][:used]
url <<