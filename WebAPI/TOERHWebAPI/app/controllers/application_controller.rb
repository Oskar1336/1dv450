require 'digest/sha2'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  protected
	@@current_username = ""
  
  def changePageLink(controller, previousPage)
    pageLink = "http://localhost:3000/api/v1/" + controller
    if params[:id].blank? == false
      pageLink += "/" + params[:id]
    end
    pageLink += "?apikey="+params[:apikey]
    if params[:page].blank? == false && previousPage == false
      pageLink += "&page="+(params[:page].to_i+1).to_s
    elsif params[:page].blank? == false && previousPage && params[:page].to_i != 1
      pageLink += "&page="+(params[:page].to_i-1).to_s
    elsif params[:page].to_i == 1
        pageLink += "&page="+params[:page]
    end
    if params[:limit].blank? == false
      pageLink += "&limit="+params[:limit]
    end
    if params[:resourcename].blank? == false
      pageLink += "&resourcename="+params[:resourcename]
    end
    if params[:callback].blank? == false
      pageLink += "&callback=JSON_CALLBACK"
    end
    
    if pageLink == "api/v1/" + controller + "?apikey="+params[:apikey]
      return ""
    end
    return pageLink
  end
  
  # Resource
  def generateResourceHash(resource)
  	resourceHash = Hash.new
  	tagArray = Array.new
  	resource.tags.each do |tag|
  		tagArray<<generateTagHash(tag)
  	end
		resourceHash["resource_id"]=resource.id
    resourceHash["resource_name"]=resource.name
    resourceHash["description"]=resource.description
    resourceHash["url"]=resource.url
    resourceHash["created"]=resource.created_at
    resourceHash["updated"]=resource.updated_at
		resourceHash["resource_type"]=generateResourceTypeHash(resource.resource_type)
		resourceHash["user"]=generateUserHash(resource.user)
		resourceHash["licence"]=generateLicenceHash(resource.licence)
		resourceHash["tags"]=tagArray
		return resourceHash
  end
  
  # Licence
  def generateLicenceHash(licence)
  	licenceHash = Hash.new
		licenceHash["id"]=licence.id
		licenceHash["licence"]=licence.licence_type
    licenceHash["allresourcesforlicence"] = "http://localhost:3000/api/v1/licence/#{licence.id}?apikey=#{params[:apikey]}"
		return licenceHash
  end
  
  # Resourcetype
  def generateResourceTypeHash(resourcetype)
  	resourcetypeHash = Hash.new
  	resourcetypeHash["id"]=resourcetype.id
  	resourcetypeHash["resourcetype"]=resourcetype.resource_type
    resourcetypeHash["allresourceforresourcetype"]="http://localhost:3000/api/v1/resourcetype/#{resourcetype.resource_type}?apikey=#{params[:apikey]}"
  	return resourcetypeHash
  end
  
  def generateUserHash(user)
    userHash = Hash.new
    userHash["username"]=user.username
    userHash["allresourceforuser"]="http://localhost:3000/api/v1/user/#{user.username}?apikey=#{params[:apikey]}"
    return userHash
  end
  
  def generateTagHash(tag)
    tagHash = Hash.new
    tagHash["tag"]=tag.tag
    tagHash["allresourcefortag"]="http://localhost:3000/api/v1/tag/#{tag.tag}?apikey=#{params[:apikey]}"
    return tagHash
  end
  
  # User validation
  def validateApiKey
    key = ApiKey.find_by key: params[:apikey]
    if key == nil
      errorHash = Hash.new
      errorHash["status"] = 401
      errorHash["errormessage"] = "Application apikey is missing or it's wrong"
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
    auth_token = request.headers["X-Auth-Token"]
    if auth_token != nil
      user = User.find_by_auth_token(auth_token)
      if user != nil
        if user.token_expires.to_date < Time.now
          @@current_username = user.username
          return true
        else
          errorHash = Hash.new
          errorHash["status"] = 401
          errorHash["errormessage"] = "Auth token is out dated"
          respond_to do |f|
            f.json { render json: errorHash, :status => 401 }
            f.xml { render xml: errorHash, :status => 401 }
          end
          return false
        end
      else
        errorHash = Hash.new
        errorHash["status"] = 401
        errorHash["errormessage"] = "Auth token is missing or it's wrong"
        respond_to do |f|
          f.json { render json: errorHash, :status => 401 }
          f.xml { render xml: errorHash, :status => 401 }
        end
        return false
      end
    else
      if auth_token == nil
        authenticate_or_request_with_http_basic do |username, password|
          @@current_username = username
          User.authenticate(username, password)
        end
      end
    end
  end
    
  def auth_admin
    if session[:username]
      return true
    else
      flash[:loginnotice] = "You must be signed in as admin to view the requested page."
      redirect_to :controller => "login", :action => "login"
      return false
    end
  end
  
  def save_login_state
    if session[:username]
      redirect_to :controller => "admin", :action => "index"
      return false
    else
      return true
    end
  end
end
  
