# import libraries for spotify api and web framework
require 'sinatra'
require 'rspotify'

# set client id and secret for Spotify api authentication
CLIENT_ID = '385e6488ef94426ba908c9ef1b56f3e8'
CLIENT_SECRET = '94a33109b6a140a0bbd9985fad32515a'
RSpotify.authenticate("#{CLIENT_ID}", "#{CLIENT_SECRET}")

# Sinatra configuration(from documentation)
set :protection, :except => :frame_options
set :bind, '127.0.0.1'
set :port, 1000
set :public_folder, 'public'

# set background color
background_style = 'background-color: #242424; color #ffffff;'
song_box_background_color = 'background-color: #444444;'

# home page route
get '/' do
  erb :index, locals: { background_style: background_style }
end

# route for the spotify search results
post '/search' do
  query = params[:search_query]
  @results = RSpotify::Track.search(query)

  erb :search_results, locals: { results: @results, background_style: background_style, song_box_background_color: song_box_background_color }
end

__END__
