class SessionController < ApplicationController
	
	def create
		auth = request.env["omniauth.auth"]
		
		user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || 
					 User.create_with_omniauth(auth["provider"], auth["uid"], auth["info"]["nickname"], auth["info"]["email"])
		
		user.name = auth["info"]["name"]
		user.token = auth["credentials"]["token"]
		user.auth_token = SecureRandom.urlsafe_base64(nil, false)
		user.token_expires = Time.now + 1.hour
		user.save
		
		url = session[:client_call]
		session[:client_call] = nil
		redirect_to "#{url}?auth_token=#{user.auth_token}&token_expires=#{Rack::Utils.escape(user.token_expires.to_s)}"
	end
	
	def destroy
		
	end
	
	def authenticate
		session[:client_call] = params[:callback]
		redirect_to "/auth/github"
	end
	
end
