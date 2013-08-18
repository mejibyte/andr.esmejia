# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  helper_method :current_user_session, :current_user, :logged_in?

  before_filter :force_domain

  private

  def force_domain
    if Rails.env.production? && request.host != "andr.esmejia.com"
      redirect_to request.url.sub(request.host, "andr.esmejia.com"), status: :moved_permanently
    end
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def logged_in?
    current_user != nil
  end

  def require_user
    unless logged_in?
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to new_user_session_path
      return false
    end
  end

  def require_no_user
    if logged_in?
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to posts_path
      return false
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
end
