class SettingsController < ApplicationController
  def show
  end

  def delete
    @user = User.find(params[:id])
  end
end
