class AdminController < ApplicationController
  before_filter :auth_admin, :only => [:loggedin, :logout]
  before_filter :save_login_state, :only => [:login, :login_attempt]
  
  def login
  end

  def login_attempt
  	if params[:login][:username] == "Admin" && params[:login][:password] == "Password"
      session[:username] = "Admin"
      flash[:notice] = "Welcome ADMIN"
  		redirect_to :action => "loggedin"
  	else
  		flash[:notice] = "Invalid username/password combination"
  		render "login"
  	end
  end
  
  def loggedin
    
  end
  
  def logout
    session[:username] = nil
    redirect_to :controller => "home", :action => "index"
  end
end
