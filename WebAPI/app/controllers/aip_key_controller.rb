class AipKeyController < ApplicationController
	protect_from_forgery with: :null_session
  	def index
  		# Show login/register form
  	end
  	
  	def new
  		@new_application = Application.new
  	end
  	
  	def create
  		@application = Application.new
  		@application.contact_mail = params[:email]
  		@application.applicationname = params[:appname]
  		if @application.save == false
  			render :action => "new"
  		end
  		
  		@apiKey = ApiKey.new
  		@apiKey.application_id = @application.id
  		@apiKey.auth_token = generateApiKey
  		if @apiKey.save
  			redirect_to :action => "index"
  		else
  			render :action => "new"
  		end
  	end
  	
  	def edit
  		
  	end
  	
  	def generateApiKey
  		@s = "AbCdEfGhIjKlMnOpQrStUvWxYz0123456789"
  		@s.split("").shuffle.join
  	end
end
