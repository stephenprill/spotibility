class UsersController < ApplicationController

  def spotify
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    session[:token] = request.env['omniauth.auth']['credentials']['token']
    user = User.find_or_initialize_by(spotify_id: request.env['omniauth.auth']['extra']['raw_info']['id'])
    user.email = request.env['omniauth.auth']['extra']['raw_info']['email']
    user.name = request.env['omniauth.auth']['extra']['raw_info']['display_name']
    # get user tracks
    tracks = call_spotify("/v1/me/tracks?limit=50")

    # parse tracks and save artists to database
    artists = tracks[:items].map do |track|
      track[:track][:artists].first[:name]
    end

    user.artists = artists
    user.save!

    # background task to search all tracks on all playlists

    session[:user_id] = user.id
    redirect_to users_path
  end

  def index
    @user = User.find(session[:user_id])
    @users = User.where("id <> ?", @user.id)
  end

  def show
    @me = User.find(session[:user_id])
    @my_playlists = call_spotify("/v1/users/#{@me.spotify_id}/playlists")
    @my_tracks = {}
    @my_playlists[:items].each do |playlist|
      tracks = call_spotify("/v1/users/#{@me.spotify_id}/playlists/#{playlist[:id]}/tracks")[:items]
      @my_tracks[playlist[:id]] = tracks
    end

    @my_artists= []

    @my_playlists[:items].each do |playlist|
      if @my_tracks[playlist[:id]]
        @my_tracks[playlist[:id]].each do |track|
          @my_artists += track[:track][:artists].map{|artist| artist[:name] }
        end
      end
    end
    @my_artists.uniq!
    @my_artists.sort!

    @user = User.find(params[:id])
    @user_playlists = call_spotify("/v1/users/#{@user.spotify_id}/playlists")
    @user_tracks = {}
    @user_playlists[:items].each do |playlist|
      tracks = call_spotify("/v1/users/#{@user.spotify_id}/playlists/#{playlist[:id]}/tracks")[:items]
      @user_tracks[playlist[:id]] = tracks
    end

    @user_artists = []

    @user_playlists[:items].each do |playlist|
      if @user_tracks[playlist[:id]]
        @user_tracks[playlist[:id]].each do |track|
          @user_artists += track[:track][:artists].map{|artist| artist[:name] }
        end
      end
    end
    @user_artists.uniq!
    @user_artists.sort!

    @compare = @user_artists + @my_artists
    @total_artists = @compare.length
    @unique_artists = @compare.uniq.length
    @difference = @total_artists - @unique_artists
    @match_percentage = ((@difference/@unique_artists.to_f) * 100).round(2)
  end

  private

  def call_spotify(path)
    token = session[:token]

    conn = Faraday.new(:url => 'https://api.spotify.com/')
    response = conn.get(path) do |req|
      req.headers['Authorization'] = "Bearer #{token}"
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
