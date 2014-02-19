class LoginController < ApplicationController
  before_filter :save_login_state
  
  def login
  end
  
  def login_attempt
  	if params[:login][:username] == "Admin" && params[:login][:password] == "Password"
      session[:username] = "Admin"
  		redirect_to :controller => "admin", :action => "index"
  	else
  		flash.now[:loginnotice] = "Invalid username/password creadentials"
  		render "login"
  	end
  end
end
