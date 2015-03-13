class AuthenticationsController < ApplicationController

  def signout
    session.clear
    redirect_to users_path
  end
end
