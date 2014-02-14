class User < ActiveRecord::Base
	has_many :resources
	
	# Validate
	validates :firstname, :lastname, :email, :presence => true
end
