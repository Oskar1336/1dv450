class User < ActiveRecord::Base
	has_many :resources
	
	validates :username, :email, uniqueness: true
	
	
	def self.create_with_omniauth(provider, uid, username, email)
		create! do |user|
			user.provider = provider
			user.uid = uid
			user.username = username
			user.email = email
		end
	end
end
