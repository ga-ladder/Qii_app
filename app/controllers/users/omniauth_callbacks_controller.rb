class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.find_for_google(request.env['omniauth.auth'])

    if @user.persisted?
      if @user.sign_in_count == 0
        redirect_to edit_user_path(@user)
      else
        flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
        # after_sign_in_path_for で定義したリダイレクト先に@userの値を持って飛ぶ
        sign_in_and_redirect @user, event: :authentication
      end
    else
      session['devise.google_data'] = request.env['omniauth.auth']
      flash[:alert] = I18n.t 'devise.omniauth_callbacks.fail', kind: 'Google'
      redirect_to new_user_registration_path
    end
  end

  def github
    @user = User.find_for_github_oauth(request.env["omniauth.auth"])
    binding.pry

    if @user.persisted?
      if @user.sign_in_count == 0
        redirect_to edit_user_path(@user)
      else
        sign_in_and_redirect @user, :event => :authentication
        set_flash_message(:notice, :success, :kind => "Github") if is_navigational_format?
      end
    else
      session["devise.github_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end

