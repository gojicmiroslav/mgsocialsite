# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# The create! method is just like the create method, except it raises an exception for
# an invalid user rather than returning false. This behavior makes debugging
# easier by avoiding silent errors.

# Users
User.create!(	name: "Miroslav Gojic",
							email: "miroslavy2k@gmail.com",
							password: "deronje",
							password_confirmation: "deronje",
							admin: true)

99.times do |n|
	name = Faker::Name.name
	email = "example-#{n+1}@railstutorial.org"
	password = "password"
	User.create!(	name: name,
								email: email,
								password: password,
								password_confirmation: password)
end
