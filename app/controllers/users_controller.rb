class UsersController < ApplicationController

  def spotify
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    session[:token] = request.env['omniauth.auth']['credentials']['token']
    user = User.find_or_initialize_by(spotify_id: request.env['omniauth.auth']['extra']['raw_info']['id'])
    user.email = request.env['omniauth.auth']['extra']['raw_info']['email']

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
    # current_user = find the user by the session :id
    @user = User.find(session[:user_id])

    # end goal
    # @users = User.most_similar_to(@user)

    # case 1
    @users = User.where("id <> ?", @user.id)

    # case 2 - bad because of SQL injection
    # @user.id = 'DROP table users'
    # @user.id = 'SELECT * from users WHERE admin = t'
    # SQL injection
    # @users = User.where("id <> #{@user.id}")

    # case 3 - bad because looping through arrays is slower than SQL queries
    # @users = User.all
    # @users -= [@user]

    @similarity_scores = {}
    # example
    # {
    #    1: 37,
    #    2: 3,
    #    3: 0
    # }
    @users.each do |user|
      @similarity_scores[user.id] = user.similarity(@user.artists)
    end

    # sort users by overlapping artists
    # comparator
    @users.sort do |a, b|
      a.similarity(@user.artists) <=> b.similarity(@user.artists)
    end

    # get the user's spotify id (which is the currently logged in user's spotify id)
    # @tracks = call_spotify("/v1/users/#{@user.spotify_id}/playlists")
    @tracks = call_spotify("/v1/users/#{@user.spotify_id}/playlists")
    @tracks = call_spotify("/v1/me/tracks")
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
