class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_title_and_description

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_registration_path, :alert => exception.message
  end

  def after_sign_in_path_for(user)
    new_script_url
  end

  private

  def set_title_and_description
    if @calling_script
      @title = @calling_script.topic
      @description = @calling_script.summary
    else
      @title =
        "a simple tool for calling your senators and representatives in congress"
      @description =
        "Call your representatives in Congress with this easy tool! 
 Create scripts and calls-to-action, track your calls, and share with friends."
    end


  end
end
