require 'sinatra'

configure do
  # Data for each edition: image filename, description.
  set :editions, [
    ['satyre.png', 'Satyre'],
    ['porcupine.png', 'Porcuspine or Porcupine'],
    ['lamia.png', 'Lamia'],
    ['man_ape.png', 'Man Ape'],
    ['crocodile.png', 'Arabian or Egyptian Land Crocodile'],
    ['camelopardals.png', 'Camelopardals'],
    ['boa.png', 'Boa'],
    ['unicorn.png', 'Unicorn'],
    ['aegopithecus.png', 'Aegopithecus'],
    ['badger.png', 'Badger'],
    ['hydra.png', 'Hydra'],
    ['ape.png', 'Ape'],
    ['mantichora.png', 'Mantichora'],
    ['squirrel.png', 'Squirrel'],
    ['scythian_wolf.png', 'Scythian Wolf'],
    ['beaver.png', 'Beaver'],
    ['cepus_monkey.png', 'Cepus or Martime monkey'],
    ['mole.png', 'The mole or want'],
    ['sphinx.png', 'Spinga or Sphinx'],
    ['bear_ape.png', 'Bear Ape Arctopithecus'],
    ['cat.png', 'Cat'],
    ['dragon.png', 'Winged Dragon'],
    ['prasyan_ape.png', 'Prasyan Ape'],
    ['su.png', 'A wilde beaste in the New Found World called SU'],
    ['bear.png', 'Bear'],
    ['sagoin.png', 'Sagoin, called Galeopithecus'],
    ['lion.png', 'Lion'],
    ['another_monster.png', 'Another Monster'],
    ['adder.png', 'Adder'],
    ['african_bugil.png', 'African Bugil'],
    ['allocamelus.png', 'Allocamelus'],
    ['alpine_mouse.png', 'Alpine Mouse'],
  ]
end


# Called to generate the sample shown on BERG Cloud Remote.
get '/sample/' do
  # We can choose which edition we want as the sample:
  @delivery_count = 0
  @image_name = settings.editions[@delivery_count][0]
  @description = settings.editions[@delivery_count][1]
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

  if (@delivery_count + 1) > settings.editions.length
    # The publication has finished, so unsubscribe this subscriber.
    return 410

  elsif ! date.wednesday?
    # No content is delivered this day.
    return 204

  else
    # It's all good, so display the publication.
    @image_name = settings.editions[@delivery_count][0]
    @description = settings.editions[@delivery_count][1]
    content_type 'text/html; charset=utf-8'
    etag Digest::MD5.hexdigest(@delivery_count.to_s + Date.today.strftime('%d%m%Y'))
    erb :edition
  end
end

