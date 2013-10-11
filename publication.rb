require 'sinatra'


configure do
  set :descriptions, [
      'Satyre',
      'Porcuspine or Porcupine',
      'Lamia',
      'Man Ape',
      'Arabian or Egyptian Land Crocodile',
      'Camelopardals',
      'Boa',
      'Unicorn',
      'Beaver',
      'Aegopithecus',
      'Badger',
      'Hydra',
      'Ape',
      'Mantichora',
      'Squirrel',
      'Scythian Wolf',
      'Beaver',
      'Cepus or Martime monkey',
      'The mole or want',
      'Spinga or Sphinx',
      'Bear Ape Arctopithecus',
      'Cat',
      'Winged Dragon',
      'Prasyan Ape',
      'A wilde beaste in the New Found World called SU',
      'Bear',
      'Sagoin, called Galeopithecus',
      'Lion',
    ]
end


# Called to generate the sample shown on BERG Cloud Remote.
get '/sample/' do
  @delivery_count = 0
  @description = settings.descriptions[@delivery_count]
  content_type 'text/html; charset=utf-8'
  etag Digest::MD5.hexdigest('sample' + Date.today.strftime('%d%m%Y'))
  erb :edition
end


# Called by BERG Cloud to generate publication output to print.
get '/edition/' do

  if params[:delivery_count]
    @delivery_count = params[:delivery_count].to_i
  else
    # A sensible default.
    @delivery_count = 0
  end

  if params[:local_delivery_time]
    date = Time.parse(params[:local_delivery_time])
  else
    date = Time.now
  end

  if ! date.wednesday?
    # No content is delivered this day.
    etag Digest::MD5.hexdigest('empty' + Date.today.strftime('%d%m%Y'))
    return 204

  elsif (@delivery_count + 1) > settings.descriptions.length
    # The publication has finished, so unsubscribe this subscriber.
    return 410

  else
    # It's all good, so display the publication.
    @description = settings.descriptions[@delivery_count]
    content_type 'text/html; charset=utf-8'
    etag Digest::MD5.hexdigest(@delivery_count.to_s + Date.today.strftime('%d%m%Y'))
    erb :edition
  end
end

