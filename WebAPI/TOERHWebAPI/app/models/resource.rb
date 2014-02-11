class Resource < ActiveRecord::Base
	has_and_belongs_to_many :tag
	belongs_to :User
	belongs_to :ResourceType
	belongs_to :Licence
	
	# Validation
	validates :ResourceType_id, :User_id, :Licence_id, :presence => true
end
