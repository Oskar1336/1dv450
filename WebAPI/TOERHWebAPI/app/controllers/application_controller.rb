require 'digest/sha2'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery
  
  protected
  	@@current_username = ""
  
  # Resource
	  def generateResourceHash(resource)
	  	resourceHash = Hash.new
			resourceHash["statuscode"]=200
			resourceHash["resource_id"]=resource.id
			resourceHash["resource_type_id"]=resource.resource_type_id
			resourceHash["resource_type"]=resource.resource_type
			resourceHash["username"]=resource.user.username
			resourceHash["licence_id"]=resource.licence_id
			resourceHash["licence"]=resource.licence
			resourceHash["description"]=resource.description
			resourceHash["url"]=resource.url
			resourceHash["tags"]=resource.tags
			return resourceHash
	  end
  
  # User validation
  	def validateApiKey
  		key = ApiKey.find_by key: params[:apikey]
			if key == nil
				errorHash = Hash.new
				errorHash["statuscode"] = 401
				errorHash["Errormessage"] = "Application apikey is missing or it's wrong"
				respond_to do |f|
					f.json { render json: errorHash, :status => 401 }
					f.xml { render xml: errorHash, :status => 401 }
				end
				return false
			else
				return true
			end
  	end
  	
  	def validateUser
  		authenticate_or_request_with_http_basic do |username, password|
				@@current_username = username
				User.find_by_username(username).password == Digest::SHA512.hexdigest(password) && params[:username] == username
			end
  	end
end
