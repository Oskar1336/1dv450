class ApiKey < ActiveRecord::Base
	belongs_to :Application
	
	# Validation
	validates_associated :Application
end
