require 'digest/sha2'

class Api::V1::ResourceController < ApplicationController
	before_filter :validateApiKey
	before_filter :validateUser, :except => [:index, :show]
	
	# GET: api/v1/resource?apikey=s4ciD75L69UAXz0y8QrhJfbNVOm3T21wGkpe  test apikey
	def index
		resources = Resource.all
		if resources != nil
			resultArray = Array.new
			resources.each do |resource|
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
				resultArray << resourceHash
			end
			respond_to do |f|
				f.json { render json: resultArray, :status => 200 }
				f.xml { render xml: resultArray, :status => 200 }
			end
		else
			respond_to do |f|
				f.json { render json: "Found no resources", :status => 404 }
				f.xml { render xml: "Found no resources", :status => 404 }
			end
		end
	end
	
	# GET: api/v1/resource/:id?apikey=s4ciD75L69UAXz0y8QrhJfbNVOm3T21wGkpe  test apikey
	def show
		begin
			resource = Resource.find(params[:id])
			
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
			
			respond_to do |f|
				f.json { render json: resourceHash, :status => 200 }
				f.xml { render xml: resourceHash, :status => 200 }
			end
		rescue
			errorHash = Hash.new
			errorHash["statuscode"] = 404
			errorHash["Errormessage"] = "Resource not found"
			respond_to do |f|
				f.json { render json: errorHash, :status => 404 }
				f.xml { render xml: errorHash, :status => 404 }
			end
		end
	end
	
	# @TODO: validate parameters.
	# POST: api/v1/resource?apikey=s4ciD75L69UAXz0y8QrhJfbNVOm3T21wGkpe&username=oskar  testing parameters
	# JSON: {
	#   "resource": {
	#     "name":"Name of resource",
	#     "resourcetype":"Resource type",
	#     "licencetype":"Licence type",
	#     "description":"Resource description",
	#     "url":"Resource location",
	#     "tags":[Array of resource tags]
	#   }
	# }
	def create
		if params[:resource] != nil
			resourcetype = ResourceType.find_or_create_by_resource_type(params[:resource][:resourcetype])
			licencetype = Licence.find_or_create_by_licence_type(params[:resource][:licencetype])
			description = params[:resource][:description]
			name = params[:resource][:name]
			url = params[:resource][:url]
			tags = params[:resource][:tags]
			user = User.find_by_username(params[:username])
			
			resource = Resource.new
			resource.name = name
			resource.resource_type_id = resourcetype.id
			resource.user_id = user.id
			resource.licence_id = licencetype.id
			resource.description = description
			resource.url = url
			resource.created_at = DateTime.now
			resource.updated_at = DateTime.now
			resource.save
			
			tags.each do |tag|
				tagInfo = Tag.find_or_create_by_tag(tag)
				resource.tags << tagInfo
			end
			respond_to do |f|
				f.json { render json: resource, :status => 201 }
				f.xml { render xml: resource, :status => 201 }
			end
		else
			errorHash = Hash.new
			errorHash["statuscode"] = 404
			errorHash["Errormessage"] = "Check your JSON body resource parameter not found"
			respond_to do |f|
				f.json { render json: errorHash, :status => 404 }
				f.xml { render xml: errorHash, :status => 404 }
			end
		end
	end
	
	# PUT: api/v1/resource/:id?apikey=s4ciD75L69UAXz0y8QrhJfbNVOm3T21wGkpe&username=oskar  testing parameters
	def update
		begin
			if params[:resource].blank? == false
				resource = Resource.find(params[:id])
				if params[:resource][:resourcetype].blank? == false
					resource_type = ResourceType.find_or_create_by_resource_type(params[:resource][:resourcetype])
					resource.resource_type_id = resource_type.id
				end
				if params[:resource][:licencetype].blank? == false
					licence = Licence.find_or_create_by_licence_type(params[:resource][:licencetype])
					resource.licence_id = licence.id
				end
				if params[:resource][:description].blank? == false
					resource.description = params[:resource][:description]
				end
				if params[:resource][:url].blank? == false
					resource.url = params[:resource][:url]
				end
				if params[:resource][:name].blank? == false
					resource.name = params[:resource][:name]
				end
				if params[:resource][:tags].blank? == false
					tags = params[:resource][:tags]
					tags.each do |tag|
						tagInfo = Tag.find_or_create_by_tag(tag)
						resource.tags << tagInfo
					end
				end
				resource.save
				render :nothing => true, :status => 200
			else
				errorHash = Hash.new
				errorHash["statuscode"] = 400
				errorHash["Errormessage"] = "'resource' element missing in request body"
				respond_to do |f|
					f.json { render json: errorHash, :status => 400 }
					f.xml { render xml: errorHash, :status => 400 }
				end
			end
		rescue
			errorHash = Hash.new
			errorHash["statuscode"] = 404
			errorHash["Errormessage"] = "Did not find the requested resource"
			respond_to do |f|
				f.json { render json: errorHash, :status => 404 }
				f.xml { render xml: errorHash, :status => 404 }
			end
		end		
	end
	
	# @TODO: validate parameters.
	# DELETE: api/v1/resource/:id?apikey=s4ciD75L69UAXz0y8QrhJfbNVOm3T21wGkpe&username=oskar  testing parameters
	def destroy
		begin
			resource = Resource.find(params[:id])
			user = User.find_by_username(params[:username])
			if resource.user_id == user.id
				resource.destroy
				respond_to do |f|
					f.json { render :nothing => true, :status => 204 }
					f.xml { render :nothing => true, :status => 204 }
				end
			else
				errorHash = Hash.new
				errorHash["statuscode"] = 403
				errorHash["Errormessage"] = "User unauthorized"
				render :json => errorHash, :status => 403
			end
		rescue
			errorHash = Hash.new
			errorHash["statuscode"] = 404
			errorHash["Errormessage"] = "Resource not found"
			render :json => errorHash, :status => 404
		end
	end
	
	private
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
				User.find_by_username(username).password == Digest::SHA512.hexdigest(password) && params[:username] == username
			end
		end
end
