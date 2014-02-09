class AdminController < ApplicationController
  before_filter :auth_admin, :only => [:loggedin, :logout]
  def loggedin
    @api_keys = ApplicationInfo.all
  end
  
  def logout
    session[:username] = nil
    redirect_to :controller => "home", :action => "index"
  end
  
  def show
    @app = ApplicationInfo.find(params[:id])
    if @app == nil
      render "loggedin"
    end
  end
  
  def edit
    @app = ApplicationInfo.find(params[:id])
    if @app == nil
      render "loggedin"
    end
  end
  
  def update
    @app = ApplicationInfo.find(params[:id])
    if @app.update_attributes(params[:app])
      redirect_to :action => "show", :id => @app
    else
      render :action => "edit"
    end
  end
  
  def destroy
    ApplicationInfo.find(params[:id]).destroy
    redirect_to :action => "loggedin"
  end
end
