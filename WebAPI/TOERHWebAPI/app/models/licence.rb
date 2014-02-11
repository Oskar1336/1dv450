class Licence < ActiveRecord::Base
	has_many :Resources, :class_name => "Resource", :foreign_key => "Licence_id"
	
	# Validation
	validates :licence_type, :presence => true
end
