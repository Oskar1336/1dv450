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
  	tagArray = Array.new
  	resource.tags.each do |tag|
  		tagArray<<generateTagHash(tag)
  	end
		resourceHash["resource_id"]=resource.id
		resourceHash["resource_type"]=generateResourceTypeHash(resource.resource_type)
		resourceHash["user"]=generateUserHash(resource.user)
		resourceHash["licence"]=generateLicenceHash(resource.licence)
		resourceHash["description"]=resource.description
		resourceHash["url"]=resource.url
		resourceHash["tags"]=tagArray
    resourceHash["created"]=resource.created_at
		return resourceHash
  end
  
  # Licence
  def generateLicenceHash(licence)
  	licenceHash = Hash.new
		licenceHash["id"]=licence.id
		licenceHash["licence"]=licence.licence_type
		return licenceHash
  end
  
  # Resourcetype
  def generateResourceTypeHash(resourcetype)
  	resourcetypeHash = Hash.new
  	resourcetypeHash["id"]=resourcetype.id
  	resourcetypeHash["resourcetype"]=resourcetype.resource_type
  	return resourcetypeHash
  end
  
  # User
  def generateUserHash(user)
  	userHash = Hash.new
		userHash["firstname"]=user.firstname
		userHash["lastname"]=user.lastname
		userHash["username"]=user.username
		userHash["email"]=user.email
		return userHash
  end
  
  # Tag
  def generateTagHash(tag)
  	tagHash = Hash.new
  	tagHash["id"]=tag.id
  	tagHash["tag"]=tag.tag
  	return tagHash
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
				User.find_by_username(username).password == Digest::SHA512.hexdigest(password)
			end
  	end
end
