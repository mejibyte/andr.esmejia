class UserSessionsController < ApplicationController
  layout "admin"
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  
  def new
  end
  
  def create
    salt = "d40b3f20aca34409c09f24dd0a2a490801ac0ef310043ec8b25c6c9a842bbd054cc49da232d3819b"
    if Digest::SHA1.hexdigest(params[:session][:password] + salt) == "029acabaa8aba965221b3f3ff0c1c50029abbe26"
      session[:user_id] = User.find_by_email!("andmej@gmail.com")
      flash[:notice] = "Login successful!"
      redirect_back_or_default posts_path
    else
      render :action => :new
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logout successful!"
    redirect_back_or_default new_user_session_path
  end
end
