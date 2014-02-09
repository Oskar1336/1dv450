class HomeController < ApplicationController
  def index
  end
  
  def new
    @appinfo = ApplicationInfo.new
  end
  
  # @todo: Add successmessage
  def create
  	apistring = "QwErTyUiOpAsDfGhJkLmNbVcXz0123456789"
  	@appinfo = ApplicationInfo.new
    @appinfo.applicationname = params[:application_info][:applicationname]
    @appinfo.email = params[:application_info][:email]
    @appinfo.apikey = apistring.split('').shuffle.join
  	if @appinfo.save
      flash[:newappnotice] = "Successfully created, Your apikey will soon be in you inbox"
      redirect_to :action => "index"
    else
      render "new"
    end
  end
end
