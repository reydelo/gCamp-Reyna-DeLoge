class UsersController<ApplicationController
  before_filter :authenticate

  def authenticate
    redirect_to(signup_path) unless current_user
  end

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users=User.all
  end

  def new
    @user=User.new
  end

  def create
    @user=User.new(user_params)
    if @user.save
      redirect_to users_path(@user), notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
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
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
  
end
