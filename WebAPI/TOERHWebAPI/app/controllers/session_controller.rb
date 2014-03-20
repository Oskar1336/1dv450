class SessionController < ApplicationController
before_filter :validateUser, :except => [:destroy, :create, :authenticate]
	
	def create
		auth = request.env["omniauth.auth"]
		
		user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || 
					 User.create_with_omniauth(auth["provider"], auth["uid"], auth["info"]["nickname"])
		
		user.token = auth["credentials"]["token"]
		user.auth_token = SecureRandom.urlsafe_base64(nil, false)
		user.token_expires = Time.now + 5.hours
		user.save
		
		url = session[:client_call]
		session[:client_call] = nil
		redirect_to "#{url}?auth_token=#{user.auth_token}&token_expires=#{Rack::Utils.escape(user.token_expires.to_s)}&username=#{user.username}"
	end
	
	def destroy
		auth_token = request.headers["X-Auth-Token"]
		user = User.find_by_auth_token(auth_token)
		user.token_expires = Time.now - 1.hour
		user.save
		respond_to do |f|
			f.json { render json: :nothing, :status => 204 }
			f.xml { render xml: :nothing, :status => 204 }
		end
	end
	
	def authenticate
		session[:client_call] = params[:callback]
		redirect_to "/auth/github"
	end
	
end
