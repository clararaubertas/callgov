class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def callback
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => @kind) if is_navigational_format?
    # else
    #   set_flash_message(:alert, :failure, :kind => @kind, :reason => failure_message) if is_navigational_format?
    #   redirect_to '/'
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
