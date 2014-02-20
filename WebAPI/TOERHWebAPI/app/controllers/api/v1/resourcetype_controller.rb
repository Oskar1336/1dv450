class Api::V1::ResourcetypeController < ApplicationController
	before_filter :validateApiKey
	
	# GET: api/v1/resourcetype?apikey=dsoumefehknkkxkumkkuzvmulclcdtkhcdwukbtg&resourcetype=Picture&limit=10
	def index
		resourcetypes = nil
		if params[:limit]
			resourcetypes = ResourceType.all().limit(params[:limit].to_i)
		else
			resourcetypes = ResourceType.all
		end
		if resourcetypes != nil
			resultArray = Array.new
			resultHash = Hash.new
			resourcetypes.each do |resourcetype|
				resultArray << generateResourceTypeHash(resourcetype)
			end
			resultHash["status"]=200
			resultHash["resourcetypes"]=resultArray
			respond_to do |f|
				f.json { render json: resultHash, :status => 200 }
				f.xml { render xml: resultHash, :status => 200 }
			end
		else
			errorHash = Hash.new
			errorHash["status"] = 404
			errorHash["errormessage"] = "Found no resource types"
			respond_to do |f|
				f.json { render json: errorHash, :status => 404 }
				f.xml { render xml: errorHash, :status => 404 }
			end
		end
	end
	
	# GET: api/v1/resourcetype/:resourcetype?apikey=dsoumefehknkkxkumkkuzvmulclcdtkhcdwukbtg&limit=10
	def show
		q = "%#{params[:id]}%"
		resourcetypes = nil
		if params[:limit]
			resourcetypes = ResourceType.where("resource_type LIKE ?", q).limit(params[:limit].to_i)
		else
			resourcetypes = ResourceType.where("resource_type LIKE ?", q)
		end
		if resourcetypes.any?
			resultHash = Hash.new
			resultArray = Array.new
			resourcetypes.each do |resourcetype|
				tempHash = Hash.new
				tempArray = Array.new
				resourcetype.resources.each do |resource|
					tempArray<<generateResourceHash(resource)
				end
				tempHash["resourcetype"]=generateResourceTypeHash(resourcetype)
				tempHash["resources"]=tempArray
				resultArray<<tempHash
			end
			resultHash["status"]=200
			resultHash["result"]=resultArray
			respond_to do |f|
				f.json { render json: resultHash, :status => 200 }
				f.xml { render xml: resultHash, :status => 200 }
			end
		else
			errorHash = Hash.new
			errorHash["status"] = 404
			errorHash["errormessage"] = "Found no such resource type"
			respond_to do |f|
				f.json { render json: errorHash, :status => 404 }
				f.xml { render xml: errorHash, :status => 404 }
			end
		end
	end
end
