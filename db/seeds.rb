# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(email: "user@example.com", password: "password", first_name: "Example", last_name: "User", city: "Cracow", country: "Poland")
user2 = User.create(email: "userx@example.com", password: "password", first_name: "Other", last_name: "User", city: "Cracow", country: "Poland")

# User Avatar
user.avatar = File.open("#{Rails.root}/app/assets/images/rails.png")
user.save

user2.avatar = File.open("#{Rails.root}/app/assets/images/rails.png")
user2.save

user.active!
user2.active!

# Invitations
(0..4).each do |i|
  u = User.create(email: "user#{i}@example.com", password: "password", first_name: "First#{i}", last_name: "Last#{i}", city: "Cracow", country: "Poland")
  u.active
  invitation = u.invitations.build
  invitation.training = true
  invitation.invited = user
  invitation.save
end

(5..10).each do |i|
  u = User.create(email: "user#{i}@example.com", password: "password", first_name: "First#{i}", last_name: "Last#{i}", city: "Cracow", country: "Poland")
  invitation = u.invitations.build
  invitation.friend = true
  invitation.invited = user
  invitation.save
end

# Friendships && Trainings

5.times do |i|
  u = User.create(email: "user#{i}#{i}@example.com", password: "password", first_name: "First#{i}#{i}", last_name: "Last#{i}#{i}", city: "Cracow", country: "Poland")
  u.direct_friends << user
  u.user_coaches << user
  u.trained_users << user
end

# Messages
22.times do |i|
  message = Message.new
  message.subject = "Message #{i}"
  message.body = "bla bla bla bla bla bla bla bla bla"
  message.sender = user2
  message.recipient = user
  message.save
end

5.times do |i|
  message = Message.new
  message.subject = "Sent Message #{i}"
  message.body = "bla bla bla bla bla bla bla bla bla"
  message.sender = user
  message.recipient = user2
  message.save
end

# Disciplines

judo = Discipline.create(name: "Judo")
swimming = Discipline.create(name: "Swimming")
krav_maga = Discipline.create(name: "Krav Maga")

user.disciplines << [judo, swimming, krav_maga]
user2.disciplines << [judo, swimming, krav_maga]

# Place
p = Place.create(name: "Swimmingpool")
p.location = Location.create(city: "Cracow")
p.save
p.disciplines << swimming

p = Place.create(name: "Fight Club")
p.location = Location.create(city: "Cracow")
p.save
p.disciplines << judo
p.disciplines << krav_maga

# Prohibitions
user.prohibitions << Prohibition.create(name: "Broken Leg")
Prohibition.create(name: "Broken Arm")

# Parameters
user.parameters << Parameter.create(height: 180, weight: 90)
user.parameters << Parameter.create(height: 180, weight: 89)
user.parameters << Parameter.create(height: 180, weight: 93)
