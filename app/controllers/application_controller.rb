class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :ensure_current_user, except: :spotify

  def ensure_current_user
    unless current_user
      session[:first_url] = request.url if request.get?
      redirect_to root_path, notice: 'You must be logged in to access that action'
    end
  end

  def current_user
      User.find_by(id: session[:user_id])
  end



  helper_method :current_user
end
