class ApiKey < ActiveRecord::Base
	belongs_to :application
	
	# Validation
	validates_associated :application
end
