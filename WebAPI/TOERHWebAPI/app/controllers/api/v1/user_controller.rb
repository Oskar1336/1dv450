class Api::V1::UserController < ApplicationController
	before_filter :validateApiKey
	before_filter :validateUser, :except => [:index, :show]
	
	# GET: api/v1/user?apikey=dsoumefehknkkxkumkkuzvmulclcdtkhcdwukbtg&limit=10&page=1
	def index
		users = nil
		if params[:limit].blank? == false
			if params[:page].blank? == false
				users = User.all.paginate(page: params[:page], per_page: params[:limit])
			else
				users = User.all.limit(params[:limit].to_i)
			end
		elsif params[:page].blank? == false
			users = User.all.paginate(page: params[:page], per_page: 10)
		else
			users = User.all
		end
		
		if users.blank? == false
			resultHash = Hash.new
			resultArray = Array.new
			users.each do |user|
				resultArray << generateUserHash(user)
			end
			resultHash["status"] = 200
			resultHash["users"] = resultArray
			if params[:page].blank? == false
				resultHash["nextPage"]=changePageLink("user", false)
				resultHash["previousPage"]=changePageLink("user", true)
			end
			respond_to do |f|
				f.json { render json: resultHash, :status => 200 }
				f.xml { render xml: resultHash, :status => 200 }
			end
		else
			errorHash = Hash.new
			errorHash["status"] = 404
			errorHash["errormessage"] = "Found no users"
			respond_to do |f|
				f.json { render json: errorHash, :status => 404 }
				f.xml { render xml: errorHash, :status => 404 }
			end
		end
	end
	
	# GET :api/v1/tag/:username?apikey=dsoumefehknkkxkumkkuzvmulclcdtkhcdwukbtg&limit=10&page=1
	def show
		user = User.find_by_username(params[:id])
		if user.blank? == false
			resultHash = Hash.new
			resultArray = Array.new
			resources = nil
			if params[:limit].blank? == false
				if params[:page].blank? == false
					resources = user.resources.paginate(page: params[:page], per_page: params[:limit])
				else
					resources = user.resources.limit(params[:limit].to_i)
				end
			elsif params[:page].blank? == false
					resources = user.resources.paginate(page: params[:page], per_page: 10)
			else
				resources = user.resources
			end
			
			resources.each do |resource|
				resultArray << generateResourceHash(resource)
			end
			
			resultHash["status"]=200
			resultHash["username"]=user.username
			resultHash["resources"]=resultArray
			if params[:page].blank? == false
				resultHash["nextPage"]=changePageLink("user", false)
				resultHash["previousPage"]=changePageLink("user", true)
			end
			respond_to do |f|
				f.json { render json: resultHash, :status => 200 }
				f.xml { render xml: resultHash, :status => 200 }
			end
		else
			errorHash = Hash.new
			errorHash["status"] = 404
			errorHash["errormessage"] = "Found no such user"
			respond_to do |f|
				f.json { render json: errorHash, :status => 404 }
				f.xml { render xml: errorHash, :status => 404 }
			end
		end
	end
	
	# POST api/v1/tag/:username?apikey=dsoumefehknkkxkumkkuzvmulclcdtkhcdwukbtg
	def create
		if params[:user].blank? == false
			email = params[:user][:email]
			name = params[:user][:name]
			username = params[:user][:username]
			password = params[:user][:password]
			
			if email.blank? == false && name.blank? == false && username.blank? == false && password.blank? == false
				user = User.new
				user.username = username
				user.provider = "Local"
				user.auth_token = SecureRandom.urlsafe_base64(nil, false)
				user.token_expires = Time.now + 5.hours
				user.password_digest = password #Digest::SHA512.hexdigest(password)
				if user.save
					resultHash = Hash.new
					resultHash["status"]=204
					respond_to do |f|
						f.json { render json: resultHash, :status => 204 }
						f.xml { render xml: resultHash, :status => 204 }
					end
				else
					errorHash = Hash.new
					errorHash["status"] = 400
					errorHash["errormessage"] = "Parameters did not pass validation"
					respond_to do |f|
						f.json { render json: errorHash, :status => 400 }
						f.xml { render xml: errorHash, :status => 400 }
					end
				end
			else
				errorHash = Hash.new
					errorHash["status"] = 400
					errorHash["errormessage"] = "Required parameters missing"
					respond_to do |f|
						f.json { render json: errorHash, :status => 400 }
						f.xml { render xml: errorHash, :status => 400 }
					end
			end
		else
			errorHash = Hash.new
			errorHash["status"] = 400
			errorHash["errormessage"] = "Check your JSON body, 'user' parameter not found"
			respond_to do |f|
				f.json { render json: errorHash, :status => 400 }
				f.xml { render xml: errorHash, :status => 400 }
			end
		end
	end
end
