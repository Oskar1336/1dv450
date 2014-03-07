class Api::V1::UserController < ApplicationController
	before_filter :validateApiKey
	
	# GET: api/v1/tag?apikey=dsoumefehknkkxkumkkuzvmulclcdtkhcdwukbtg&limit=10
	def index
		users = nil
		if params[:limit].blank? == false
			users = User.all().limit(params[:limit].to_i)
		else
			users = User.all
		end
		if users != nil
			resultHash = Hash.new
			resultArray = Array.new
			users.each do |user|
				resultArray << generateUserHash(user)
			end
			resultHash["status"] = 200
			resultHash["users"] = resultArray
			respond_to do |f|
				f.json { render json: resultHash, callback: params["callback"], :status => 200 }
				f.xml { render xml: resultHash, :status => 200 }
			end
		else
			errorHash = Hash.new
			errorHash["status"] = 404
			errorHash["errormessage"] = "Found no users"
			respond_to do |f|
				f.json { render json: errorHash, callback: params["callback"], :status => 404 }
				f.xml { render xml: errorHash, :status => 404 }
			end
		end
	end
	
	# GET :api/v1/tag/:username?apikey=dsoumefehknkkxkumkkuzvmulclcdtkhcdwukbtg&limit=10
	def show
		user = User.find_by_username(params[:id])
		if user != nil
			resultHash = Hash.new
			resultArray = Array.new
			resources = nil
			if params[:limit].blank? == false
				resources = user.resources.limit(params[:limit].to_i)
			else
				resources = user.resources
			end
			resources.each do |resource|
				resultArray << generateResourceHash(resource)
			end
			resultHash["status"]=200
			resultHash["username"]=user.username
			resultHash["resources"]=resultArray
			respond_to do |f|
				f.json { render json: resultHash, callback: params["callback"], :status => 200 }
				f.xml { render xml: resultHash, :status => 200 }
			end
		else
			errorHash = Hash.new
			errorHash["status"] = 404
			errorHash["errormessage"] = "Found no such user"
			respond_to do |f|
				f.json { render json: errorHash, callback: params["callback"], :status => 404 }
				f.xml { render xml: errorHash, :status => 404 }
			end
		end
	end
end
