class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  protected
  def auth_admin
  	if session[:username]
  		return true
  	else
  		redirect_to :controller => "login", :action => "login"
  		return false
  	end
  end
  def save_login_state
  	if session[:username]
  		redirect_to :controller => "admin", :action => "loggedin"
  		return false
  	else
  		return true
  	end
  end
end
