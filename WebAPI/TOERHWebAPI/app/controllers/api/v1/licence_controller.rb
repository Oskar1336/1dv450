class Api::V1::LicenceController < ApplicationController
	before_filter :validateApiKey
	
	# GET: api/v1/licence?apikey=dsoumefehknkkxkumkkuzvmulclcdtkhcdwukbtg&limit=10&page=1
	def index
		licences = nil
		if params[:limit].blank? == false
			if params[:page].blank? == false
				licences = Licence.all.paginate(page: params[:page], per_page: params[:limit])
			else
				licences = Licence.all.limit(params[:limit].to_i)
			end
		elsif params[:page].blank? == false
			licences = Licence.all.paginate(page: params[:page], per_page: 10)
		else
			licences = Licence.all
		end
		
		if licences.blank? == false
			resultHash = Hash.new
			resultArray = Array.new
			licences.each do |licence|
				resultArray<<generateLicenceHash(licence)
			end
			
			resultHash["status"]=200
			resultHash["licences"]=resultArray
			if params[:page].blank? == false
				resultHash["nextPage"]=changePageLink("licence", false)
				resultHash["previousPage"]=changePageLink("licence", true)
			end
			respond_to do |f|
				f.json { render json: resultHash, :status => 200 }
				f.xml { render xml: resultHash, :status => 200 }
			end
		else
			errorHash = Hash.new
			errorHash["status"] = 404
			errorHash["errormessage"] = "Found no licences"
			respond_to do |f|
				f.json { render json: errorHash, :status => 404 }
				f.xml { render xml: errorHash, :status => 404 }
			end
		end
	end
	
	# GET: api/v1/licence/:id?apikey=dsoumefehknkkxkumkkuzvmulclcdtkhcdwukbtg&limit=10&page=1
	def show
		begin
			licence = Licence.find(params[:id])
			resultArray = Array.new
			resultHash = Hash.new
			resources = nil
			
			if params[:limit].blank? == false
				if params[:page].blank? == false
					resources = licence.resources.paginate(page: params[:page], per_page: params[:limit])
				else
					resources = licence.resources.limit(params[:limit].to_i)
				end
			elsif params[:page].blank? == false
				resources = licence.resources.paginate(page: params[:page], per_page: 10)
			else
				resources = licence.resources
			end
			
			resources.each do |resource|
				resultArray << generateResourceHash(resource)
			end
			
			resultHash["status"]=200
			resultHash["licenceid"]=generateLicenceHash(licence)
			resultHash["resources"]=resultArray
			if params[:page].blank? == false
				resultHash["nextPage"]=changePageLink("licence", false)
				resultHash["previousPage"]=changePageLink("licence", true)
			end
			respond_to do |f|
				f.json { render json: resultHash, :status => 200 }
				f.xml { render xml: resultHash, :status => 200 }
			end
		rescue
			errorHash = Hash.new
			errorHash["status"] = 404
			errorHash["errormessage"] = "Found no such licence"
			respond_to do |f|
				f.json { render json: errorHash, :status => 404 }
				f.xml { render xml: errorHash, :status => 404 }
			end
		end
	end
end
