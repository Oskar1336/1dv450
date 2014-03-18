class HomeController < ApplicationController
	def index
	end
	
	def new
		@app = Application.new
	end
	
	def create
		@app = Application.new
		@app.contact_mail = params[:application][:contact_mail]
		@app.application_name = params[:application][:application_name]
		if @app.save
			apikey = ApiKey.new
			apikey.Application_id = @app.id
			apikey.key = generateApiKey
			while apikey.save == false
				apikey.key = generateApiKey
			end
			
			flash[:newappnotice] = "Successfully created, Your apikey: " + apikey.key + " save this."
			redirect_to :action => "index"
		else
			render "new"
		end
	end
	
	private
	def generateApiKey
		apistring = "QwErTyUiOpAsDfGhJkLmNbVcXz0123456789"
		return apistring.split('').shuffle.join
	end
	
end
