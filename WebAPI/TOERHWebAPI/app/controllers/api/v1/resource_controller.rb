require 'digest/sha2'

class Api::V1::ResourceController < ApplicationController
	before_filter :validateApiKey
	before_filter :validateUser, :except => [:index, :show]
	
	# GET: api/v1/resource?apikey=yourAPIKey
	def index
		resources = Resource.all
		if resource != nil
			@resultArray = Array.new
			resources.each do |resource|
				resourceHash = Hash.new
				resourceHash["resource_id"]=resource.id
				resourceHash["resource_type_id"]=resource.resource_type_id
				resourceHash["resource_type"]=resource.resource_type
				resourceHash["user_id"]=resource.user_id
				resourceHash["user"]=resource.user
				resourceHash["licence_id"]=resource.licence_id
				resourceHash["licence"]=resource.licence
				resourceHash["description"]=resource.description
				resourceHash["url"]=resource.url
				resourceHash["tags"]=resource.tags
				@resultArray << resourceHash
			end
			respond_to do |f|
				f.json { render json: @resultArray, :status => 200 }
				f.xml { render xml: @resultArray, :status => 200 }
			end
		else
			respond_to do |f|
				f.json { render json: "Found no resources", :status => 404 }
				f.xml { render xml: "Found no resources", :status => 404 }
			end
		end
	end
	
	# GET: api/v1/resource/:id?apikey=yourAPIKey
	def show
		begin
			resource = Resource.find(params[:id])
			
			resourceHash = Hash.new
			resourceHash["resource_id"]=resource.id
			resourceHash["resource_type_id"]=resource.resource_type_id
			resourceHash["resource_type"]=resource.resource_type
			resourceHash["user_id"]=resource.user_id
			resourceHash["username"]=resource.user.username
			resourceHash["licence_id"]=resource.licence_id
			resourceHash["licence"]=resource.licence
			resourceHash["description"]=resource.description
			resourceHash["url"]=resource.url
			resourceHash["tags"]=resource.tags
			
			respond_to do |f|
				f.json { render json: resourceHash, :status => 200 }
				f.xml { render xml: resourceHash, :status => 200 }
			end
		rescue
			respond_to do |f|
				f.json { render json: "The requested resource was not found", :status => 404 }
				f.xml { render xml: "The requested resource was not found", :status => 404 }
			end
		end
	end
	
	# POST: api/v1/resource?apikey=yourAPIKey
	def create
		if params[:resource] != nil
			resourcetype = ResourceType.find_or_create_by_resource_type(params[:resource][:resourcetype])
			licencetype = Licence.find_or_create_by_licence_type(params[:resource][:licencetype])
			description = params[:resource][:description]
			url = params[:resource][:url]
			tags = params[:resource][:tags]
			user = User.find_by_username(params[:username])
			
			resource = Resource.new
			resource.resource_type_id = resourcetype.id
			resource.user_id = user.id
			resource.licence_id = licencetype.id
			resource.description = description
			resource.url = url
			resource.created_at = DateTime.now.to_date
			resource.updated_at = DateTime.now.to_date
			resource.save
			
			tags.each do |tag|
				tagInfo = Tag.find_or_create_by_tag(tag)
				resource.tags << tagInfo
			end
			render :json => resource, :status => 201
		else
			render :json => "", :status => 400
		end
	end
	
	# PUT: api/v1/resource/:id?apikey=yourAPIKey
	def update
		render :nothing => true, :status => 404
	end
	
	# DELETE: api/v1/resource/:id?apikey=yourAPIKey
	def destroy
		Resource.find(params[:id]).destroy
		render :nothing => true, :status => 204
	end
	
	private
	def validateApiKey
		key = ApiKey.find_by key: params[:apikey]
		if key == nil
			errorHash = Hash.new
			errorHash["statuscode"] = 401
			errorHash["Errormessage"] = "Application apikey is missing or it's wrong"
			errorHash["Fix"] = "Check your apikey and correct if wrong"
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
			User.find_by_username(username).password == Digest::SHA512.hexdigest(password) && params[:username] == username
		end
	end
end
