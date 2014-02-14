class ResourceType < ActiveRecord::Base
	has_many :resources
	
	# Validation
	validates :resource_type, :presence => true
end
