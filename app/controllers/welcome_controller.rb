class WelcomeController < ApplicationController
  require 'rspotify'

  def index
    if params[:q]
      @artists = RSpotify::Artist.search(params[:q])
    else

      ## client: 8b1a2f49127e496ba2eae4203127694d
      ## client secret 60cf0492e972495cb4bb1310b6e09802

      @user = RSpotify::User.find('stephenprill')
      # took off .new to end of like 8
      
      render :index
    end
  end

  def search
    @artists = RSpotify::Artist.search(params[:q])
  end


end
