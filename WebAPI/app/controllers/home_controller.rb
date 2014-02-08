class HomeController < ApplicationController
  def index
  end
  
  def new
  end
  
  def create
  	apistring = "QwErTyUiOpAsDfGhJkLmNbVcXz0123456789"
  	@appinfo = ApplicationInfo.new
    @appinfo.applicationname = params[:app][:application_name]
    @appinfo.email = params[:app][:email]
    @appinfo.apikey = apistring.split('').shuffle.join
  	if @appinfo.save
      redirect_to :action => "index"
    else
      render "new"
    end
  end
end
