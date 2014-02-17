class Licence < ActiveRecord::Base
	has_many :resources
	
	# Validation
	validates :licence_type, :presence => true, :allow_blank => false
end
