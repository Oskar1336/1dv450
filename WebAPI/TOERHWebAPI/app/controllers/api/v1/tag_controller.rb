class Api::V1::TagController < ApplicationController
	before_filter :validateApiKey
	
	# GET: api/v1/tag?apikey=dsoumefehknkkxkumkkuzvmulclcdtkhcdwukbtg
	def index
		tags = Tag.all
		if tags != nil
			respond_to do |f|
				f.json { render json: tags, :status => 200 }
				f.xml { render xml: tags, :status => 200 }
			end
		else
			respond_to do |f|
				f.json { render json: "Found no tags", :status => 404 }
				f.xml { render xml: "Found no tags", :status => 404 }
			end
		end
	end
	
	# GET :api/v1/tag/:tag?apikey=dsoumefehknkkxkumkkuzvmulclcdtkhcdwukbtg
	def show
		tag = Tag.find_by_tag(params[:id])
		if tag != nil
			resultArray = Array.new
			tag.resources.each do |resource|
				resultArray << generateResourceHash(resource)
			end
			respond_to do |f|
				f.json { render json: resultArray, :status => 200 }
				f.xml { render xml: resultArray, :status => 200 }
			end
		else
			respond_to do |f|
				f.json { render json: "Found no such tag", :status => 404 }
				f.xml { render xml: "Found no such tag", :status => 404 }
			end
		end
	end
end
