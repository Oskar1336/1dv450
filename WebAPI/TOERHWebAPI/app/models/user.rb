class User < ActiveRecord::Base
	has_many :resources
	validates :username, uniqueness: true
	
	before_save :encrypt_password
	
	def self.authenticate(username, password)
		user = User.find_by_username(username)
		if user && user.password_digest == BCrypt::Engine.hash_secret(password, user.password_salt)
			return user
		else
			return nil
		end
	end
	
	def encrypt_password
		if password_digest.present?
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_digest = BCrypt::Engine.hash_secret(password_digest, password_salt)
		end
	end
	
	def self.create_with_omniauth(provider, uid, username)
		create! do |user|
			user.provider = provider
			user.uid = uid
			user.username = username
		end
	end
end
