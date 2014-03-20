# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Application
#
Application.delete_all

app1 = Application.new
app1.contact_mail = "test@testmail.se"
app1.application_name="Testapp"
app1.save

# ApiKey
ApiKey.delete_all

ak = ApiKey.new
ak.key = "s4ciD75L69UAXz0y8QrhJfbNVOm3T21wGkpe"
ak.Application_id=app1.id
ak.save



#Licence
Licence.delete_all

l = Licence.new
l.licence_type="Attribution CC BY"
l.save

l = Licence.new
l.licence_type="Attribution-ShadeAlike CC BY-SA"
l.save

l = Licence.new
l.licence_type="Attribution-NoDerivs CC BY-ND"
l.save

l = Licence.new
l.licence_type="Attribution-NonCommercial CC BY-NC"
l.save

l = Licence.new
l.licence_type="Attribution-NonCommercial-ShareAlike CC BY-NC-SA"
l.save

l = Licence.new
l.licence_type="Attribution-NonCommercial-ShareAlike CC BY-NC-ND"
l.save

l = Licence.new
l.licence_type="GNU"
l.save

l = Licence.new
l.licence_type="MIT"
l.save

# ResourceType
ResourceType.delete_all

rt = ResourceType.new
rt.resource_type="Picture"
rt.save

rt = ResourceType.new
rt.resource_type="Media"
rt.save

rt = ResourceType.new
rt.resource_type="Video"
rt.save

rt = ResourceType.new
rt.resource_type="PDF"
rt.save





