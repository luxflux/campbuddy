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

a = Category.create! identifier: :red, name: 'Activities'
p = Category.create! identifier: :blue, name: 'Piste'
c = Category.create! identifier: :gray, name: 'Camp'
Event.create! owner: User.first, category: a, title: "testing", description: "these stuff", starts: Time.now + 2.hours, ends: Time.now + 4.hours
Event.create! owner: User.first, category: p, title: "skiing", description: "these stuff", starts: Time.now + 2.hours, ends: Time.now + 4.hours
Event.create! owner: User.first, category: c, title: "camping", description: "these stuff", starts: Time.now + 2.hours, ends: Time.now + 4.hours
