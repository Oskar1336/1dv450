Rails.application.config.middleware.use OmniAuth::Builder do
	provider :github, 'bd8ae96d76693821688d', '2e78102ebcbad1d1183af242c436daa6cab1de9c'
end

