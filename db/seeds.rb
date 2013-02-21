# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(email: "user@example.com", password: "password", first_name: "Example", last_name: "User")

(0..4).each do |i|
  u = User.create(email: "user#{i}@example.com", password: "password", first_name: "First#{i}", last_name: "Last#{i}")
  u.active
  invitation = u.invitations.build
  invitation.training = true
  invitation.invited = user
  invitation.save
end

(5..10).each do |i|
  u = User.create(email: "user#{i}@example.com", password: "password", first_name: "First#{i}", last_name: "Last#{i}")
  invitation = u.invitations.build
  invitation.friend = true
  invitation.invited = user
  invitation.save
end

5.times do |i|
  u = User.create(email: "user#{i}#{i}@example.com", password: "password", first_name: "First#{i}#{i}", last_name: "Last#{i}#{i}")
  u.direct_friends << user
  u.user_coaches << user
  u.trained_users << user
end
