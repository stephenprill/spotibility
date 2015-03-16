class Spotify

  def initialize(token, spotify_id)
    @token = token
    @conn = Faraday.new(:url => 'https://api.spotify.com/')
    @spotify_id = spotify_id
  end

  def playlists
    response = @conn.get("/v1/users/#{@spotify_id}/playlists") do |req|
      req.headers['Authorization'] = "Bearer #{@token}"
    end
    @playlists  = JSON.parse(response.body, symbolize_names: true)
  end

  def songs_per_playlist(playlists)
    @my_tracks = {}
    playlists[:items].each do |playlist|
      response = @conn.get("/v1/users/#{@spotify_id}/playlists/#{playlist[:id]}/tracks") do |req|
        req.headers['Authorization'] = "Bearer #{@token}"
      end
      tracks = JSON.parse(response.body, symbolize_names: true)
      @my_tracks[playlist[:id]] = tracks[:items]
    end
    @my_tracks
  end

  def setup(path)
    response = @conn.get(path) do |req|
      req.headers['Authorization'] = "Bearer #{@token}"
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def artists
    @my_artists= []
    @playlists[:items].each do |playlist|
      if @my_tracks[playlist[:id]]
        @my_tracks[playlist[:id]].each do |track|
          @my_artists += track[:track][:artists].map{|artist| artist[:name] }
        end
      end
    end
    @my_artists.uniq!
    @my_artists.sort!
    @my_artists

  end

  # def track_names
  #   @my_track_names = []
  #   @playlists[:items].each do |track|
  #     if @my_track_names[playlist[:id]]
  #       @my_track_names[playlist[:id]].each do |track|
  #         @my_track_names += track[:track].map{|artist| [:name] }
  #         binding.pry
  #       end
  #     end
  #   end
  #   @my_track_names.uniq!
  #   @my_track_names.sort!
  #   @my_track_names
  #
  # end



end
