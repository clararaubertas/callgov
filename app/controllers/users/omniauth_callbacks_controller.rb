class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def callback
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => @kind)
    end
  end

  def google_oauth2
    @kind = "Google"
    callback
  end

  def facebook
    @kind = "Facebook"
    callback
  end

  def twitter
    @kind = "Twitter"
    callback
  end

end
