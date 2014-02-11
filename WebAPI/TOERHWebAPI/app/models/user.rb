class User < ActiveRecord::Base
	has_many :Resource
	
	# Validate
	validates :firstname, :lastname, :email, :presence => true
end
