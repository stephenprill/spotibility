class UsersController < ApplicationController
  def spotify
    puts request.env['omniauth.auth']
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])

    # Access private data
    puts spotify_user.country #=> "US"
    puts spotify_user.email   #=> "example@email.com"

    # Create playlist in user's Spotify account
    spotify_user.create_playlist!('LLL-winning-LLL')

    @user = spotify_user
    render :index

    # Check doc for more
  end
end
