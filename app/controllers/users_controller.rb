class UsersController < ApplicationController
  before_action :set_user, except: :index

  def index
    unless params[:value] == nil then
      @users = User.where(
        "name LIKE(?)",
        "#{params[:value]}%"
        )
    else
      @users = User.all
    end
  end

  def show
    @articles = @user.articles
  end

  def edit
  end

  def update#初回ログイン時
    if @user.update(user_base_params)
      if "更新する".freeze == params[:commit] then
        flash[:notice] = "User updated"
        redirect_back(fallback_location: settings_account_path(current_user))
      else
        flash[:notice] = "signup sccessfully"
        sign_in_and_redirect @user, event: :authentication
      end
    else
      flash[:alert] = "failed"
      redirect_to root_path
    end
  end

  def destroy
    unless current_user == @user then
      flash[:alert] = "You're not an user deleted"
      redirect_to root
    end
      @user.destroy
      flash[:notice] = "User deleted"
      redirect_to root_path
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_base_params
    params.require(:user).permit(:name, :email, :avatar)
  end
end
