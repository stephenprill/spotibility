class WelcomeController < ApplicationController
  require 'rspotify'

  def index
    @artists = RSpotify::Artist.search('Tom Waits')
  end


end
