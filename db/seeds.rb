# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.where(email: 'admin@example.org')
if admin.first
  puts 'Admin already existed with email admin@example.org'
else
  admin.first_or_create!(firstname: 'Mr', name: 'Admin', password: 'adminpass', admin: true)
  puts 'Created admin: admin@example.org/adminpass'
end

User.create! firstname: 'Andreas', name: 'Pluss', email: 'test@test.com', password: 'robidog', admin: true
User.create! firstname: 'Robi', name: 'Dogi', email: 'robi@dogi.com', password: 'robidog', admin: false
User.create! firstname: 'Simon', name: 'Wittwer', email: 'widdi@test.com', password: 'robidog', admin: false

a = Category.red.where(name: 'Activities').first_or_create
p = Category.blue.where(name: 'Piste').first_or_create
c = Category.gray.where(name: 'Camp').first_or_create

#puts("------------")
#puts(Event.methods.sort)
#puts("------------")

Event.create! owner: User.first, category: a, title: "testing", description: "these stuff", starts: Time.now + 2.hours, ends: Time.now + 4.hours
Event.create! owner: User.first, category: p, title: "skiing", description: "these stuff", starts: Time.now + 2.hours, ends: Time.now + 4.hours
Event.create! owner: User.first, category: c, title: "camping", description: "these stuff", starts: Time.now + 2.hours, ends: Time.now + 4.hours

Event.create! owner: User.first, category: a, title: "Foto", description: "Fotographie-Kurs", starts: Time.now + 4.hours, ends: Time.now + 5.hours
Event.create! owner: User.first, category: p, title: "Snowboar-Kurs", description: "Späte Action auf der Piste, es wird SUPER!", starts: Time.now + 4.hours, ends: Time.now + 5.hours
Event.create! owner: User.first, category: c, title: "camping", description: "these stuff", starts: Time.now + 4.hours, ends: Time.now + 5.hours

