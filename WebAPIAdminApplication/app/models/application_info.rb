class ApplicationInfo < ActiveRecord::Base
	validates :email, :applicationname, :apikey, presence: true
	validates :apikey, uniqueness: true
end
