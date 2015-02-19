class UsersController < ApplicationController

  def spotify
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    session[:token] = request.env['omniauth.auth']['credentials']['token']
    user = User.find_or_initialize_by(spotify_id: request.env['omniauth.auth']['extra']['raw_info']['id'])
    user.email = request.env['omniauth.auth']['extra']['raw_info']['email']
    user.save!
    session[:user_id] = user.id
    redirect_to users_path
  end

  def index
    @users = User.all
    # current_user = find the user by the session :id
    # get the user's spotify id (which is the currently logged in user's spotify id)
    # @tracks = call_spotify("/v1/users/#{@user.spotify_id}/playlists")
    @tracks = call_spotify("/v1/me")
  end

  def show
    @user = User.find(params[:id])

    @playlists = call_spotify("/v1/users/#{@user.spotify_id}/playlists")

    @tracks = {}

    @playlists[:items].each do |playlist|
      tracks = call_spotify("/v1/users/#{@user.spotify_id}/playlists/#{playlist[:id]}/tracks")[:items]
      @tracks[playlist[:id]] = tracks
    end
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
