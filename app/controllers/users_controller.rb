class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    user_service = UsersService.new(user_params)
    @user = user_service.user
    if user_service.create_user
      redirect_to users_path
    else
      respond_to do |format|
        format.js { render 'users/user_management.js.erb', layout: false, locals: { action: 'new' } }
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    user_service = UsersService.new(user_params, @user)
    if user_service.update_user
      redirect_to users_path
    else
      respond_to do |format|
        format.js { render 'users/user_management.js.erb', layout: false, locals: { action: 'edit' } }
      end
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path
  end

  def show; end

  def user_params
    params.require(:user).permit(:email, :password, :user_type, :password_confirmation)
  end

end
