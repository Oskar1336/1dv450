class Api::V1::ResourcetypeController < ApplicationController
	before_filter :validateApiKey
	
	# GET: api/v1/resourcetype?apikey=dsoumefehknkkxkumkkuzvmulclcdtkhcdwukbtg&resourcetype=Picture
	def index
		resourcetypes = ResourceType.all
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
	
	# GET: api/v1/resourcetype/:resourcetype?apikey=dsoumefehknkkxkumkkuzvmulclcdtkhcdwukbtg
	def show
		q = "%#{params[:resourcetype]}%"
		resourcetypes = ResourceType.where("resource_type LIKE ?", q)
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
