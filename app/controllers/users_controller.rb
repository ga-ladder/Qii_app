class UsersController < ApplicationController
  before_action :set_user


  def show
  end

  def edit
  end

  def update#初回ログイン時
    @user.update(user_base_params)
    sign_in_and_redirect @user, event: :authentication
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_base_params
    params.require(:user).permit(:name, :email)
  end
end
