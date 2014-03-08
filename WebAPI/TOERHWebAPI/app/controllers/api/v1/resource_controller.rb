class Api::V1::ResourceController < ApplicationController
	before_filter :validateApiKey
	before_filter :validateUser, :except => [:index, :show]
	
	# GET: api/v1/resource?apikey=s4ciD75L69UAXz0y8QrhJfbNVOm3T21wGkpe&resourcename=Test&limit=10&page=1
	def index
		resources = nil
		if params[:limit].blank? == false
			if params[:page].blank? == false
				resources = Resource.all.paginate(page: params[:page], per_page: params[:limit])
			else
				resources = Resource.all.limit(params[:limit].to_i)
			end
		elsif params[:page].blank? == false
			resources = Resource.all.paginate(page: params[:page], per_page: 10)
		elsif params[:resourcename].blank? == false
			query = "%#{params[:resourcename]}%"
			if params[:limit].blank? == false
				if params[:page].blank? == false
					resources = Resource.where("name LIKE ?", query).paginate(page: params[:page], per_page: params[:limit])
				else
					resources = Resource.where("name LIKE ?", query).limit(params[:limit].to_i)
				end
			elsif params[:page].blank? == false
				resources = Resource.where("name LIKE ?", query).paginate(page: params[:page], per_page: 10)
			else
				resources = Resource.where("name LIKE ?", query)
			end
		else
			resources = Resource.all
		end
		
		if resources.blank? == false
			resultArray = Array.new
			resultHash = Hash.new
			resources.each do |resource|
				resultArray << generateResourceHash(resource)
			end
			resultHash["status"]=200
			resultHash["resources"]=resultArray
			resultHash["nextPage"]=changePageLink("resource", false)
			resultHash["previousPage"]=changePageLink("resource", true)
			respond_to do |f|
				f.json { render json: resultHash, callback: params["callback"], :status => 200 }
				f.xml { render xml: resultHash, :status => 200 }
			end
		else
			errorHash = Hash.new
			errorHash["status"] = 404
			errorHash["errormessage"] = "Found no resources"
			respond_to do |f|
				f.json { render json: errorHash, callback: params["callback"], :status => 404 }
				f.xml { render xml: errorHash, :status => 404 }
			end
		end
	end

	# GET: api/v1/resource/:id?apikey=s4ciD75L69UAXz0y8QrhJfbNVOm3T21wGkpe
	def show
		begin
			resource = Resource.find(params[:id])
			resultHash = Hash.new
			resultHash["status"]=200
			resultHash["resource"]=generateResourceHash(resource)
			respond_to do |f|
				f.json { render json: resultHash, callback: params["callback"], :status => 200 }
				f.xml { render xml: resultHash, :status => 200 }
			end
		rescue
			errorHash = Hash.new
			errorHash["status"] = 404
			errorHash["errormessage"] = "Resource not found"
			respond_to do |f|
				f.json { render json: errorHash, callback: params["callback"], :status => 404 }
				f.xml { render xml: errorHash, :status => 404 }
			end
		end
	end
	
	# POST: api/v1/resource?apikey=s4ciD75L69UAXz0y8QrhJfbNVOm3T21wGkpe
	def create
		if params[:resource].blank? == false
			resourcetypeparam = params[:resource][:resourcetype]
			licencetypeparam = params[:resource][:licencetype]
			description = " "
			if params[:resource][:description].blank? == false
				description = params[:resource][:description]
			end
			url = params[:resource][:url]
			tags = params[:resource][:tags]
			name = params[:resource][:name]
			
			if name.blank? == false && licencetypeparam.blank? == false && resourcetypeparam.blank? == false && url.blank? == false
				user = User.find_by_username(@@current_username)
				licencetype = Licence.find_or_create_by_licence_type(licencetypeparam)
				resourcetype = ResourceType.find_or_create_by_resource_type(resourcetypeparam)
				resource = Resource.new
				resource.name = name
				resource.resource_type_id = resourcetype.id
				resource.user_id = user.id
				resource.licence_id = licencetype.id
				resource.description = description
				resource.url = url
				resource.created_at = DateTime.now
				resource.updated_at = DateTime.now
				tags.each do |tag|
					tagInfo = Tag.find_or_create_by_tag(tag)
					resource.tags << tagInfo
				end
				if resource.save
					resultHash = Hash.new
					resultHash["status"]=201
					resultHash["resource"]=generateResourceHash(resource)
					respond_to do |f|
						f.json { render json: resultHash, :status => 201 }
						f.xml { render xml: resultHash, :status => 201 }
					end
				else
					errorHash = Hash.new
					errorHash["status"] = 400
					errorHash["errormessage"] = "Parameters did not pass validation"
					respond_to do |f|
						f.json { render json: errorHash, callback: params["callback"], :status => 400 }
						f.xml { render xml: errorHash, :status => 400 }
					end
				end
			else
				errorHash = Hash.new
				errorHash["status"] = 400
				errorHash["errormessage"] = "Required parameters missing"
				respond_to do |f|
					f.json { render json: errorHash, callback: params["callback"], :status => 400 }
					f.xml { render xml: errorHash, :status => 400 }
				end
			end
		else
			errorHash = Hash.new
			errorHash["status"] = 400
			errorHash["errormessage"] = "Check your JSON body, 'resource' parameter not found"
			respond_to do |f|
				f.json { render json: errorHash, callback: params["callback"], :status => 400 }
				f.xml { render xml: errorHash, :status => 400 }
			end
		end
	end
	
	# PUT: api/v1/resource/:id?apikey=s4ciD75L69UAXz0y8QrhJfbNVOm3T21wGkpe
	def update
		begin
			if params[:resource].blank? == false
				resource = Resource.find(params[:id])
				if params[:resource][:resourcetype].blank? == false
					resource_type = ResourceType.find_or_create_by_resource_type(params[:resource][:resourcetype])
					resource.resource_type_id = resource_type.id
				end
				if params[:resource][:licencetype].blank? == false
					licence = Licence.find_or_create_by_licence_type(params[:resource][:licencetype])
					resource.licence_id = licence.id
				end
				if params[:resource][:description].blank? == false
					resource.description = params[:resource][:description]
				end
				if params[:resource][:url].blank? == false
					resource.url = params[:resource][:url]
				end
				if params[:resource][:name].blank? == false
					resource.name = params[:resource][:name]
				end
				if params[:resource][:tags].blank? == false
					tags = params[:resource][:tags]
					tags.each do |tag|
						tagInfo = Tag.find_or_create_by_tag(tag)
						resource.tags << tagInfo
					end
				end
				user = User.find_by_username(@@current_username)
				if user.id == resource.user_id
					resource.updated_at = DateTime.now
					if resource.save
						resultHash = Hash.new
						resultHash["status"]=200
						resultHash["resource"]=generateResourceHash(resource)
						respond_to do |f|
							f.json { render json: resultHash, callback: params["callback"], :status => 200 }
							f.xml { render xml: resultHash, :status => 200 }
						end
					else
						errorHash = Hash.new
						errorHash["status"] = 400
						errorHash["errormessage"] = "Parameters did not pass validation"
						respond_to do |f|
							f.json { render json: errorHash, callback: params["callback"], :status => 400 }
							f.xml { render xml: errorHash, :status => 400 }
						end
					end
				else
					errorHash = Hash.new
					errorHash["status"] = 403
					errorHash["errormessage"] = "Current user does not have access to this resource"
					respond_to do |f|
						f.json { render json: errorHash, callback: params["callback"], :status => 403 }
						f.xml { render xml: errorHash, :status => 403 }
					end
				end
			else
				errorHash = Hash.new
				errorHash["status"] = 400
				errorHash["errormessage"] = "'resource' element missing in request body"
				respond_to do |f|
					f.json { render json: errorHash, callback: params["callback"], :status => 400 }
					f.xml { render xml: errorHash, :status => 400 }
				end
			end
		rescue
			errorHash = Hash.new
			errorHash["status"] = 404
			errorHash["errormessage"] = "Did not find the requested resource"
			respond_to do |f|
				f.json { render json: errorHash, callback: params["callback"], :status => 404 }
				f.xml { render xml: errorHash, :status => 404 }
			end
		end		
	end
	
	# DELETE: api/v1/resource/:id?apikey=s4ciD75L69UAXz0y8QrhJfbNVOm3T21wGkpe
	def destroy
		begin
			resource = Resource.find(params[:id])
			user = User.find_by_username(@@current_username)
			if resource.user_id == user.id
				resource.destroy
				respond_to do |f|
					f.json { render :nothing => true, :status => 204 }
					f.xml { render :nothing => true, :status => 204 }
				end
			else
				errorHash = Hash.new
				errorHash["status"] = 403
				errorHash["errormessage"] = "User unauthorized"
				render :json => errorHash, :status => 403
			end
		rescue
			errorHash = Hash.new
			errorHash["status"] = 404
			errorHash["errormessage"] = "Resource not found"
			render :json => errorHash, :status => 404
		end
	end
end
