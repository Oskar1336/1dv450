class Resource < ActiveRecord::Base
	has_and_belongs_to_many :tags
	belongs_to :user
	belongs_to :licence
	belongs_to :resource_type
end
