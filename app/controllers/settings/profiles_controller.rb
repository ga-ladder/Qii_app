class Settings::ProfilesController < ApplicationController
  before_action :set_profile
  def show
  end
  def create
    @profile.update(profile_params)
    unless @profile.save
      redirect_to settings_profile_path(current_user), alert: "saving faild!!"
    end
    redirect_to settings_profile_path(current_user), notice: "seve successfully!!"
  end
  def update
    @profile.update(profile_params)
    unless @profile.save
      redirect_to settings_profile_path(current_user), alert: "saving faild!!"
    end
    redirect_to settings_profile_path(current_user), notice: "seve successfully!!"
  end

  private
  def set_profile
    profile = User.find(current_user.id).profile
    if profile.nil?
      @profile = Profile.new(user_id: current_user.id)
    else
      @profile = Profile.find_by(user_id: current_user.id)
    end
  end

  def profile_params
    params.require(:profile).permit(
      :first_name,
      :last_name,
      :open_email,
      :blog_url,
      :group,
      :city,
      :introduce,
      :facebook_url,
      :linkedin_url,
      :google_url
      )
  end
end
