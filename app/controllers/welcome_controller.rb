class WelcomeController < ApplicationController
  require 'rspotify'

  def index
    @artists = RSpotify::Artist.search(params[:q])
  end

  # def search
  #   @artists = RSpotify::Artist.search(params[:q])
  # end


end
