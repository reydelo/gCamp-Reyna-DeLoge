class UsersController<ApplicationController
  before_action :authenticate
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
    render layout: "internal"
  end

  def new
    @user = User.new
    render layout: "internal"
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path(@user), notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def show
    render layout: "internal"
  end

  def edit
    if admin || current_user.id == @user.id
      render layout: "internal"
    else
      render :file => "/public/404.html",  :status => 404
    end
  end

  def update
    if @user.update(user_params)
      redirect_to users_path(@user), notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if current_user == @user.destroy
      redirect_to signup_path, notice: 'You have successfully destroyed your account. Please register to gain access.'
    elsif @user.destroy
      redirect_to users_path, notice: 'User was successfully destroyed.'
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :admin)
  end

end
