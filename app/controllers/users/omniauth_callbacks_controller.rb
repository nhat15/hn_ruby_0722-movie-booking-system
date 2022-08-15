class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    generic_callback("facebook")
  end

  def google_oauth2
    generic_callback("google_oauth2")
  end

  private

  def generic_callback provider
    @user = User.omniauth_user(request.env["omniauth.auth"])
    @user.skip_confirmation!
    @user.save
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      if is_navigational_format?
        set_flash_message(:notice, :success,
                          kind: provider.capitalize)
      end
    else
      session["devise.#{provider}_data"] =
        request.env["omniauth.auth"].except("extra")
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
