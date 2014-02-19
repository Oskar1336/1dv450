class Api::V1::LicenceController < ApplicationController
	before_filter :validateApiKey
	
	# GET: api/v1/licence?apikey=dsoumefehknkkxkumkkuzvmulclcdtkhcdwukbtg
	def index
		licences = Licence.all
		if licences != nil
			respond_to do |f|
				f.json { render json: licences, :status => 200 }
				f.xml { render xml: licences, :status => 200 }
			end
		else
			respond_to do |f|
				f.json { render json: "Found no licences", :status => 404 }
				f.xml { render xml: "Found no licences", :status => 404 }
			end
		end
	end
	
	# GET: api/v1/licence/:id?apikey=dsoumefehknkkxkumkkuzvmulclcdtkhcdwukbtg
	def show
		begin
			licence = Licence.find(params[:id])
			resultArray = Array.new
			licence.resources.each do |resource|
				resultArray << generateResourceHash(resource)
			end
			respond_to do |f|
				f.json { render json: resultArray, :status => 200 }
				f.xml { render xml: resultArray, :status => 200 }
			end
		rescue
			respond_to do |f|
				f.json { render json: "Found no such licence", :status => 404 }
				f.xml { render xml: "Found no such licence", :status => 404 }
			end
		end
	end
end
