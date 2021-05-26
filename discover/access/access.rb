def set_secrets()
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