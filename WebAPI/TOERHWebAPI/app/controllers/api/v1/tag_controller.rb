class Api::V1::TagController < ApplicationController
	before_filter :validateApiKey
	
	# GET: api/v1/tag?apikey=dsoumefehknkkxkumkkuzvmulclcdtkhcdwukbtg&limit=10
	def index
		tags = nil
		if params[:limit].blank? == false
			tags = Tag.all().limit(params[:limit].to_i)
		else
			tags = Tag.all	
		end
		if tags != nil
			resultHash = Hash.new
			resultArray = Array.new
			tags.each do |tag|
				resultArray<<generateTagHash(tag)
			end
			resultHash["status"]=200
			resultHash["tags"]=resultArray
			respond_to do |f|
				f.json { render json: resultHash, :status => 200 }
				f.xml { render xml: resultHash, :status => 200 }
			end
		else
			errorHash = Hash.new
			errorHash["status"] = 404
			errorHash["errormessage"] = "Found no tags"
			respond_to do |f|
				f.json { render json: errorHash, :status => 404 }
				f.xml { render xml: errorHash, :status => 404 }
			end
		end
	end
	
	# GET :api/v1/tag/:tag?apikey=dsoumefehknkkxkumkkuzvmulclcdtkhcdwukbtg&limit=10
	def show
		tag = Tag.find_by_tag(params[:id])
		if tag != nil
			resultArray = Array.new
			resultHash = Hash.new
			resources = nil
			if params[:limit].blank? == false
				resources = tag.resources.limit(params[:limit].to_i)
			else
				resources = tag.resources
			end
			resources.each do |resource|
				resultArray << generateResourceHash(resource)
			end
			resultHash["status"]=200
			resultHash["tag"]=generateTagHash(tag)
			resultHash["resources"]=resultArray
			respond_to do |f|
				f.json { render json: resultHash, :status => 200 }
				f.xml { render xml: resultHash, :status => 200 }
			end
		else
			errorHash = Hash.new
			errorHash["status"] = 404
			errorHash["errormessage"] = "Found no such tag"
			respond_to do |f|
				f.json { render json: errorHash, :status => 404 }
				f.xml { render xml: errorHash, :status => 404 }
			end
		end
	end
end
