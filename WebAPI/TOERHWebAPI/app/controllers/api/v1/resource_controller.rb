class Api::V1::ResourceController < ApplicationController
	before_filter :validateApiKey
	
	
	
	def index
		resources = Resource.all
		@resultArray = Array.new
		resources.each do |resource|
			resourceArray = Hash.new
			resourceArray["resource_id"]=resource.id
			resourceArray["resource_type_id"]=resource.resource_type_id
			resourceArray["resource_type"]=resource.resource_type
			resourceArray["user_id"]=resource.user_id
			resourceArray["user"]=resource.user
			resourceArray["licence_id"]=resource.licence_id
			resourceArray["licence"]=resource.licence
			resourceArray["description"]=resource.description
			resourceArray["url"]=resource.url
			resourceArray["tags"]=resource.tags
			@resultArray << resourceArray
		end
		respond_to do |f|
			f.json { render json: @resultArray, :status => 200 }
			f.xml { render xml: @resultArray, :status => 200 }
		end
	end
	
	def show
		resource = Resource.find(params[:id])
		if resource != nil
			@resultArray = Array.new
			resourceArray = Hash.new
			resourceArray["resource_id"]=resource.id
			resourceArray["resource_type_id"]=resource.resource_type_id
			resourceArray["resource_type"]=resource.resource_type
			resourceArray["user_id"]=resource.user_id
			resourceArray["user"]=resource.user
			resourceArray["licence_id"]=resource.licence_id
			resourceArray["licence"]=resource.licence
			resourceArray["description"]=resource.description
			resourceArray["url"]=resource.url
			resourceArray["tags"]=resource.tags
			@resultArray << resourceArray
			respond_to do |f|
				f.json { render json: @resultArray, :status => 200 }
				f.xml { render xml: @resultArray, :status => 200 }
			end
		else
			respond_to do |f|
				f.json { render json: "Not found", :status => 404 }
				f.xml { render xml: "Not found", :status => 404 }
			end
		end
	end
	
	def create
		
		render :nothing => true, :status => 403
	end
	
	def update
		render :nothing => true, :status => 403
	end
	
	def destroy
		render :nothing => true, :status => 404
	end
	
	private
	def validateApiKey
		key = ApiKey.find_by key: params[:apikey]
		if key == nil
			respond_to do |f|
				f.json { render json: "Unauthorized", :status => 403 }
				f.xml { render xml: "Unauthorized", :status => 403 }
			end
			return false
		else
			return true
		end
	end
	
	def validateUser
		# Validate current user
	end
end
