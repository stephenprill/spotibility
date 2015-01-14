class WelcomeController < ApplicationController
  require 'rspotify'

  def index
    if params[:q]
    @artists = RSpotify::Artist.search(params[:q])
  else
    render :index
  end
end

  # def search
  #   @artists = RSpotify::Artist.search(params[:q])
  # end


end
