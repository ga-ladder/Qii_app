class ApplicationController < ActionController::Base
  def after_sign_out_path_for(resource)
    "/users/sign_in"
  end
end
