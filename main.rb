require 'rubygems'
require 'sinatra'
require 'flickr-objects'

# You need to register your own app on flickr's api page (it's really easy)
Flickr.configure do |config|
  config.api_key       = "bb0a8b3b1b3745db53302b15aad3e874"
  config.shared_secret = "2c5a626bcbc6b127"
end

get '/' do
  erb :form
end

post '/' do
  id = params[:id]
  @amount =params[:amount].to_i

  @photos = Flickr.photos.search(user_id: id)

  @photo_urls = @photos.map{|photo|
    farm_id = photo.farm
    server_id = photo.server
    id = photo.id
    secret = photo.secret

    "http://farm#{farm_id}.staticflickr.com/#{server_id}/#{id}_#{secret}.jpg"
    }

  puts @photo_urls.class
  erb :flickr
end