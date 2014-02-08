class HomeController < ApplicationController
  def index
  	
  end
  
  def new
  	@appinfo = ApplicationInfo.new
  end
  
  def create
  	apistring = "QwErTyUiOpAsDfGhJkLmNbVcXz0123456789"
  	@appinfo = ApplicationInfo.new(params[:app].permit(:applicationname, :email), apistring.split('').shuffle.join)
  	if @appinfo.save
  		redirect_to @appinfo
  	else
  		render "new"
  	end
  end
end
