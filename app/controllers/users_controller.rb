class UsersController < ApplicationController


    before_action :ensure_current_user, except: :spotify

    # def ensure_current_user
    #   unless current_user
    #     session[:first_url] = request.url if request.get?
    #     redirect_to root_path
    #   end
    # end

    # probably moves to application controller
 def ensure_current_user
   unless current_user
     redirect_to root_path
   # otherwise redirect somewhere root_path
   end
 end

  def spotify

    session[:token] = request.env['omniauth.auth']['credentials']['token']
    user = User.find_or_initialize_by(spotify_id: request.env['omniauth.auth']['extra']['raw_info']['id'])
    user.email = request.env['omniauth.auth']['extra']['raw_info']['email']

    display_name = request.env['omniauth.auth']['extra']['raw_info']['display_name']
    id = request.env['omniauth.auth']['extra']['raw_info']['id']

    user.name = display_name.presence || id

    # get user tracks

    tracks = Spotify.new(session[:token], user.spotify_id).setup("/v1/me/tracks?limit=50")

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
    @my_session = Spotify.new(session[:token], @me.spotify_id)

    @my_artists = @my_session.artists
    @my_tracks = @my_session.track_names


    @you = User.find(params[:id])
    @your_session = Spotify.new(session[:token], @you.spotify_id)

    @your_artists = @your_session.artists
    @your_tracks = @your_session.track_names


    @artist_match_percentage = Comparison.new(@my_artists, @your_artists).match
    @track_match_percentage = Comparison.new(@my_tracks, @your_tracks).match

    @match_percentage = [@track_match_percentage, @artist_match_percentage].sum.round(2) / 2
  end



    # @user = User.find(params[:id])
    # @user_playlists = call_spotify("/v1/users/#{@user.spotify_id}/playlists")
    # @user_tracks = {}
    # @user_playlists[:items].each do |playlist|
    #   tracks = call_spotify("/v1/users/#{@user.spotify_id}/playlists/#{playlist[:id]}/tracks")[:items]
    #   @user_tracks[playlist[:id]] = tracks
    # end
    #
    # @user_artists = []
    #
    # @user_playlists[:items].each do |playlist|
    #   if @user_tracks[playlist[:id]]
    #     @user_tracks[playlist[:id]].each do |track|
    #       @user_artists += track[:track][:artists].map{|artist| artist[:name] }
    #     end
    #   end
    # end
    # @user_artists.uniq!
    # @user_artists.sort!
    #



  end
