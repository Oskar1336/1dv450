class ApplicationInfo < ActiveRecord::Base
	validates :applicationname, :presence => {:message => " is required"}
	validates :email, :presence => {:message => " is required"}
	validates :apikey, :uniqueness => true, :presence => true
end
