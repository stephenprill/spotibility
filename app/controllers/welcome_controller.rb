class WelcomeController < ApplicationController
  require 'rspotify'

  def index
    if params[:q]
    @artists = RSpotify::Artist.search(params[:q])
  else

    @user = RSpotify::User.find('stephenprill').new
    binding.pry
    render :index
  end
end

  # def search
  #   @artists = RSpotify::Artist.search(params[:q])
  # end


end
