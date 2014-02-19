class Api::V1::ResourceController < ApplicationController
	before_filter :validateApiKey
	before_filter :validateUser, :except => [:index, :show]
	
	# GET: api/v1/resource?apikey=s4ciD75L69UAXz0y8QrhJfbNVOm3T21wGkpe
	def index
		resources = Resource.all
		if resources != nil
			resultArray = Array.new
			resources.each do |resource|
				resultArray << generateResourceHash(resource)
			end
			respond_to do |f|
				f.json { render json: resultArray, :status => 200 }
				f.xml { render xml: resultArray, :status => 200 }
			end
		else
			respond_to do |f|
				f.json { render json: "Found no resources", :status => 404 }
				f.xml { render xml: "Found no resources", :status => 404 }
			end
		end
	end
	
	# GET: api/v1/resource/:id?apikey=s4ciD75L69UAXz0y8QrhJfbNVOm3T21wGkpe
	def show
		begin
			resource = Resource.find(params[:id])
			resourceHash = generateResourceHash(resource)
			respond_to do |f|
				f.json { render json: resourceHash, :status => 200 }
				f.xml { render xml: resourceHash, :status => 200 }
			end
		rescue
			errorHash = Hash.new
			errorHash["statuscode"] = 404
			errorHash["Errormessage"] = "Resource not found"
			respond_to do |f|
				f.json { render json: errorHash, :status => 404 }
				f.xml { render xml: errorHash, :status => 404 }
			end
		end
	end
	
	# POST: api/v1/resource?apikey=s4ciD75L69UAXz0y8QrhJfbNVOm3T21wGkpe
	def create
		if params[:resource].blank? == false
			resourcetypeparam = params[:resource][:resourcetype]
			licencetypeparam = params[:resource][:licencetype]
			description = params[:resource][:description]
			url = params[:resource][:url]
			tags = params[:resource][:tags]
			name = params[:resource][:name]
			
			if name.blank? == false && licencetypeparam.blank? == false && resourcetypeparam.blank? == false
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
				resource.save
				
				respond_to do |f|
					f.json { render json: generateResourceHash(resource), :status => 201 }
					f.xml { render xml: generateResourceHash(resource), :status => 201 }
				end
			else
				errorHash = Hash.new
				errorHash["statuscode"] = 400
				errorHash["Errormessage"] = "Required parameters missing"
				respond_to do |f|
					f.json { render json: errorHash, :status => 404 }
					f.xml { render xml: errorHash, :status => 404 }
				end
			end
		else
			errorHash = Hash.new
			errorHash["statuscode"] = 404
			errorHash["Errormessage"] = "Check your JSON body, resource parameter not found"
			respond_to do |f|
				f.json { render json: errorHash, :status => 404 }
				f.xml { render xml: errorHash, :status => 404 }
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
					resource.save
					respond_to do |f|
						f.json { render json: generateResourceHash(resource), :status => 201 }
						f.xml { render xml: generateResourceHash(resource), :status => 201 }
					end
				else
					errorHash = Hash.new
					errorHash["statuscode"] = 403
					errorHash["Errormessage"] = "Current user does not have access to this resource"
					respond_to do |f|
						f.json { render json: errorHash, :status => 403 }
						f.xml { render xml: errorHash, :status => 403 }
					end
				end
			else
				errorHash = Hash.new
				errorHash["statuscode"] = 400
				errorHash["Errormessage"] = "'resource' element missing in request body"
				respond_to do |f|
					f.json { render json: errorHash, :status => 400 }
					f.xml { render xml: errorHash, :status => 400 }
				end
			end
		rescue
			errorHash = Hash.new
			errorHash["statuscode"] = 404
			errorHash["Errormessage"] = "Did not find the requested resource"
			respond_to do |f|
				f.json { render json: errorHash, :status => 404 }
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
				errorHash["statuscode"] = 403
				errorHash["Errormessage"] = "User unauthorized"
				render :json => errorHash, :status => 403
			end
		rescue
			errorHash = Hash.new
			errorHash["statuscode"] = 404
			errorHash["Errormessage"] = "Resource not found"
			render :json => errorHash, :status => 404
		end
	end
end
