require 'json'
require 'sinatra'


helpers do
  # editions will be an array of arrays.
  # Each sub-array be like ["ape.png", "Ape"]
  def editions
    @editions ||= JSON.parse( IO.read(Dir.pwd + '/editions.json') )
  end
end


# Called to generate the sample shown on BERG Cloud Remote.
get '/sample/' do
  # We can choose which edition we want as the sample:
  @delivery_count = 0
  @image_name = editions[@delivery_count][0]
  @description = editions[@delivery_count][1]
  content_type 'text/html; charset=utf-8'
  etag Digest::MD5.hexdigest('sample' + Date.today.strftime('%d%m%Y'))
  erb :edition
end


# Called by BERG Cloud to generate publication output to print.
get '/edition/' do
  @delivery_count = params.fetch('delivery_count', 0).to_i

  if params[:local_delivery_time]
    # local_delivery_time is like '2013-10-16T23:20:30-08:00'.
    # We strip off the timezone, as we only need to know what day this
    # date is on.
    date = Time.parse(params[:local_delivery_time][0..-7])
  else
    # Default to now.
    date = Time.now
  end

  if (@delivery_count + 1) > editions.length
    # The publication has finished, so unsubscribe this subscriber.
    return 410

  elsif ! date.wednesday?
    # No content is delivered this day.
    return 204

  else
    # It's all good, so display the publication.
    @image_name = editions[@delivery_count][0]
    @description = editions[@delivery_count][1]
    content_type 'text/html; charset=utf-8'
    etag Digest::MD5.hexdigest(@delivery_count.to_s + Date.today.strftime('%d%m%Y'))
    erb :edition
  end
end

