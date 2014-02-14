class Api::ResourceController < ApplicationController
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
			f.json { render json: @resultArray }
			f.xml { render xml: @resultArray }
		end
	end
	
	def show
		resource = Resource.find(params[:id])
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
			f.json { render json: @resultArray }
			f.xml { render xml: @resultArray }
		end
	end
	
	
end
