class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      if session[:previous_url] == nil
        redirect_to projects_path, notice: 'Welcome back'
      else
        redirect_to session[:previous_url], notice: 'Welcome back'
        session[:previous_url] = nil
      end
    else
      flash[:error] = "Username or password is incorrect"
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to '/', notice: 'You have successfully logged out'
  end

end
