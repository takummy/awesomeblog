# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

User.create(
	name: "Takummy",
	email: "takummy@email.com",
	password: "password",
	admin: true
	)


50.times do
	User.create(
		name: Faker::Name.name,
		email: Faker::Internet.email,
		password: "password"
		)
end


users = User.take(6)

20.times do

	content = Faker::Lorem.sentence(6)

	users.each { |user| user.microposts.create(content: content) }
end

users = User.all
user = User.first
followers = users[2..50]
following = users[3..40]

followers.each { |follower| follower.follow(user) }
following.each { |followed| user.follow(followed) }

microposts = Micropost.take(25)

microposts.each do |micropost|
	followers.each { |follower| follower.upvote(micropost) }
end


