class SettingsController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def delete
    @user = User.find(params[:id])
  end
end
