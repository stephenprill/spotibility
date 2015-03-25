class Spotify

  def initialize(token, spotify_id)
    @token = token
    @conn = Faraday.new(:url => 'https://api.spotify.com/')
    @spotify_id = spotify_id
  end

  def setup(path)
    response = @conn.get(path) do |req|
      req.headers['Authorization'] = "Bearer #{@token}"
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def artists
    @my_artists= []

    my_tracks.each do |playlist_id, tracks|
      tracks.each do |track|
        @my_artists += track[:track][:artists].map{|artist| artist[:name] }
      end
    end

    @my_artists.uniq!
    @my_artists.sort!
    @my_artists

  end

  def track_names
    @my_track_names = []

    my_tracks.each do |playlist_id, tracks|
      tracks.each do |track|
        @my_track_names << track[:track][:name]
      end
    end

    @my_track_names.uniq!
    @my_track_names.sort!
    @my_track_names
  end

  private

  def my_tracks
    return @my_tracks if @my_tracks.present?


    response = @conn.get("/v1/users/#{@spotify_id}/playlists") do |req|
      req.headers['Authorization'] = "Bearer #{@token}"
    end
    playlists  = JSON.parse(response.body, symbolize_names: true)

    @my_tracks = {}
    playlists[:items].each do |playlist|
      response = @conn.get("/v1/users/#{@spotify_id}/playlists/#{playlist[:id]}/tracks") do |req|
        req.headers['Authorization'] = "Bearer #{@token}"
      end
      tracks = JSON.parse(response.body, symbolize_names: true)
      @my_tracks[playlist[:id]] = tracks[:items]
    end
    # binding.pry

    @my_tracks
  end
end
