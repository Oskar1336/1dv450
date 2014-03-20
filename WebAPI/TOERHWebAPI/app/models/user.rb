class User < ActiveRecord::Base
	has_many :resources
	
	validates :username, uniqueness: true
	
	
	def self.create_with_omniauth(provider, uid, username)
		create! do |user|
			user.provider = provider
			user.uid = uid
			user.username = username
		end
	end
end
