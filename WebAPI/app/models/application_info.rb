class ApplicationInfo < ActiveRecord::Base
	#validates :email, confirmation: true
	validates :email, :applicationname, :apikey, presence: true
	validates :email, length: { minimum: 5 }
	validates :apikey, uniqueness: true
end
