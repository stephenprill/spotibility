class Comparison

  def initialize(mine, yours)
    @your_artists = yours
    @my_artists = mine
  end

  def match
    compare = @your_artists + @my_artists
    total_artists = compare.length
    unique_artists = compare.uniq.length
    difference = total_artists - unique_artists
    match_percentage = ((difference/unique_artists.to_f) * 100).round(2)
    match_percentage
  end

  def song_match
  end

end
