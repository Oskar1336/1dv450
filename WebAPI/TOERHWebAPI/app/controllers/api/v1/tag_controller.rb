class Api::V1::TagController < ApplicationController
	before_filter :validateApiKey
	
	# GET: api/v1/tag?apikey=dsoumefehknkkxkumkkuzvmulclcdtkhcdwukbtg&limit=10&page=1
	def index
		tags = nil
		if params[:limit].blank? == false
			if params[:page].blank? == false
				tags = Tag.all.paginate(page: params[:page], per_page: params[:limit])
			else
				tags = Tag.all.limit(params[:limit].to_i)
			end
		elsif params[:page].blank? == false
			tags = Tag.all.paginate(page: params[:page], per_page: 10)
		else
			tags = Tag.all
		end
		
		if tags.blank? == false
			resultHash = Hash.new
			resultArray = Array.new
			tags.each do |tag|
				resultArray<<tag.tag
			end
			resultHash["status"]=200
			resultHash["tags"]=resultArray
			if params[:page].blank? == false
				resultHash["nextPage"]=changePageLink("tag", false)
				resultHash["previousPage"]=changePageLink("tag", true)
			end
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
	
	# GET :api/v1/tag/:tag?apikey=dsoumefehknkkxkumkkuzvmulclcdtkhcdwukbtg&limit=10&page=1
	def show
		tag = Tag.find_by_tag(params[:id])
		if tag.blank? == false
			resultArray = Array.new
			resultHash = Hash.new
			resources = nil
			if params[:limit].blank? == false
				if params[:page].blank? == false
					resources = tag.resources.paginate(page: params[:page], per_page: params[:limit])
				else
					resources = tag.resources.limit(params[:limit].to_i)
				end
			elsif params[:page].blank? == false
					resources = tag.resources.paginate(page: params[:page], per_page: 10)
			else
				resources = tag.resources
			end
			resources.each do |resource|
				resultArray << generateResourceHash(resource)
			end
			resultHash["status"]=200
			resultHash["tag"]=tag.tag
			resultHash["resources"]=resultArray
			if params[:page].blank? == false
				resultHash["nextPage"]=changePageLink("tag", false)
				resultHash["previousPage"]=changePageLink("tag", true)
			end
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
