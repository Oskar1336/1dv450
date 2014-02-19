class ApiKeyMailer < ActionMailer::Base
  default from: "toerh@hotmail.com"
  
  def welcome_mail(application)
  	@app = application
  	@apikey = application.api_key
  	mail(to: @app.contact_mail, subject: "Your apikey The Open Education Resource Handler")
  end
end
