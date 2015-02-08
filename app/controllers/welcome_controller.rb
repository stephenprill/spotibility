class WelcomeController < ApplicationController
  require 'rspotify'

  def index
    if params[:q]
      @artists = RSpotify::Artist.search(params[:q])
    end
      @user1 = RSpotify::User.find('stephenprill')
      @user2 = RSpotify::User.find('topitracks')
      render :index
  end

  def search
    @artists = RSpotify::Artist.search(params[:q])
  end


end
