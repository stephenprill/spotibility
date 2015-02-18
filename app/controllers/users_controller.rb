class UsersController < ApplicationController
  def spotify
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    session[:token] = request.env['omniauth.auth']['credentials']['token']
    redirect_to users_path
  end

  def index
    @user1 = RSpotify::User.find('stephenprill')
  end
end
