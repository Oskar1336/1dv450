class ResourceType < ActiveRecord::Base
	has_many :Resources, :class_name => "Resource", :foreign_key => "ResourceType_id"
	
	# Validation
	validates :resource_type, :presence => true
end
