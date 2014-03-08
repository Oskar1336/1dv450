Rails.application.config.middleware.use OmniAuth::Builder do
	provider :github, "client_id", "client_secret"
end

