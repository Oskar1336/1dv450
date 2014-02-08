class ApplicationInfo < ActiveRecord::Base
	validates :email, :applicationname, :apikey, presence: true
	validates :email, :format => EMAIL_REGEX
	validates :apikey, uniqueness: true
end
