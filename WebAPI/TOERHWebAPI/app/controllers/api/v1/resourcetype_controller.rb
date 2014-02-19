class Api::V1::ResourcetypeController < ApplicationController
	before_filter :validateApiKey
	
	# GET: api/v1/resourcetype?apikey=dsoumefehknkkxkumkkuzvmulclcdtkhcdwukbtg
	def index
		resourcetypes = ResourceType.all
		if resourcetypes != nil
			respond_to do |f|
				f.json { render json: resourcetypes, :status => 200 }
				f.xml { render xml: resourcetypes, :status => 200 }
			end
		else
			respond_to do |f|
				f.json { render json: "Found no resource types", :status => 404 }
				f.xml { render xml: "Found no resource types", :status => 404 }
			end
		end
	end
	
	# GET: api/v1/resourcetype/:resourcetype?apikey=dsoumefehknkkxkumkkuzvmulclcdtkhcdwukbtg
	def show
		resourcetype = ResourceType.find_by_resource_type(params[:id])
		if resourcetype != nil
			resultArray = Array.new
			resourcetype.resources.each do |resource|
				resultArray << generateResourceHash(resource)
			end
			respond_to do |f|
				f.json { render json: resultArray, :status => 200 }
				f.xml { render xml: resultArray, :status => 200 }
			end
		else
			respond_to do |f|
				f.json { render json: "Found no such resource type", :status => 404 }
				f.xml { render xml: "Found no such resource type", :status => 404 }
			end
		end
	end
end
