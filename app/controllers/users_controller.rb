class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create], raise: false

  def index
    @users = User.all
  end

  def show
    @user = current_user
    @profile = @user.profile
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = sign_up(user_params)

    if @user.valid?
      sign_in(@user)
      @profile = Profile.new
      @profile.user_id = @user.id
      @profile.save
      flash[:notice] = "Success!"
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user = current_user
      @user.update(user_params)
      flash[:notice] = "Succesfully updated"
      redirect_to user_path(@user)
    else
      flash[:notice] = "Something went wrong"
      redirect_to dashboard_index_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :username)
  end
end
