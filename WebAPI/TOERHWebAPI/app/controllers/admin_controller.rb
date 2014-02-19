class AdminController < ApplicationController
	before_filter :auth_admin
	
	def index
		@app = Application.all
	end
	
	def logout
		session[:username] = nil
		redirect_to :controller => "home", :action => "index"
	end
	
	def edit
		begin
			@app = Application.find(params[:id])
		rescue
			flash[:adminnotice] = "Requested application not found"
			render "index"
		end
	end
	
	def update
		begin
			@app = Application.find(params[:id])
		if @app.update(params[:app].permit(:application_name, :contact_mail))
			redirect_to :action => "index"
		else
			render "edit"
		end
		rescue
			flash[:adminnotice] = "Requested application not found"
			render "edit"
		end
	end
	
	def destroy
		app = Application.find(params[:id])
		app.api_key.destroy
		app.destroy
		redirect_to :action => "index"
	end
end
