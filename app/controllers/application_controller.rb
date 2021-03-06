class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :admin

  def current_user
    User.find_by(id: session[:user_id])
  end

  def authorize
    redirect_to '/login' unless current_user
  end

  def authenticate
    session[:previous_url] = request.fullpath
    redirect_to(login_path) unless current_user
  end

  def admin
    current_user.admin == true
  end

end
