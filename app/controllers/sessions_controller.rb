class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to projects_path, notice: 'Welcome back'
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
