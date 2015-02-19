class User < ActiveRecord::Base
  def similarity(other_artists)
    (artists & other_artists).length
  end
end
