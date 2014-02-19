class Application < ActiveRecord::Base
	has_one :api_key
	
	# Validation
	validates :contact_mail, :application_name, :presence => true
	validates :contact_mail, uniqueness: { case_sensitive: false }, format: {
		with: /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/,
		message: "Not a valid email"
	}
end
