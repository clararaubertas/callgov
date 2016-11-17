class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  
  
  def callback
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => params[:kind]) if is_navigational_format?
    else
      set_flash_message(:notice, :failure, :kind => params[:kind]) if is_navigational_format?
    end
  end

  def google_oauth2
    callback
  end

  def facebook
    callback
  end

  def twitter
    callback
  end

end
