class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

def after_sign_out_path_for(resource)
  "/users/sign_in"
end


protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:sign_in) do |user_params|
      user_params.permit(:name, :email, :password)
    end
  end
end
