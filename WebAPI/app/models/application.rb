class Application < ActiveRecord::Base
	has_one :ApiKey
	validate_uniqueness_of :contact_mail
end
