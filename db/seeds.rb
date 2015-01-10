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

andi = User.
  where(email: 'test@test.com').
  create_with(firstname: 'Andreas', name: 'Pluss', password: 'robidog', admin: true).
  first_or_create
robi = User.
  where(email: 'robi@dogi.com').
  create_with(firstname: 'Robi', name: 'Dogi', password: 'robidog', admin: false).
  first_or_create
simi = User.
  where(email: 'widdi@test.com').
  create_with(firstname: 'Simon', name: 'Wittwer', password: 'robidog', admin: false).
  first_or_create

a = Category.red.where(name: 'Activities').first_or_create
p = Category.blue.where(name: 'Piste').first_or_create
c = Category.gray.where(name: 'Camp').first_or_create

e1 = Event.create! owner: andi,
                   category: a,
                   teaser: 'Fotos!',
                   title: "Foto",
                   description: "Fotographie-Kurs",
                   max_attendees: 2,
                   starts: Setting.camp_start + 1.day + 4.hours,
                   ends: Setting.camp_start + 1.day + 5.hours
e2 = Event.create! owner: andi,
                   category: p,
                   teaser: 'Snowboards!',
                   title: "Snowboard-Kurs",
                   max_attendees: 4,
                   description: "Späte Action auf der Piste, es wird SUPER!",
                   starts: Setting.camp_start + 2.days + 4.hours,
                   ends: Setting.camp_start + 2.days + 5.hours
e3 = Event.create! owner: simi,
                   category: c,
                   teaser: 'Camping!',
                   title: "camping",
                   description: "Lagerfeuer am Abend in der Celebration-Hall! Es gibt super Würste!",
                   starts: Setting.camp_start + 2.days + 8.hours,
                   ends: Setting.camp_start + 2.days + 10.hours

e1.users << robi
e1.users << simi

e2.users << simi

e3.users << andi
e3.users << robi


# Groups
smallgroup = Group.create! name: 'Smallgroup', leader: robi
smallgroup.users << simi
smallgroup.users << andi

smallgroup.events.create! owner: robi,
                          category: c,
                          title: 'Smallgroup',
                          teaser: 'Smallgroup!',
                          description: 'Smallgroup zum Thema Grillwürste',
                          starts: Setting.camp_start + 1.day + 8.hours,
                          ends: Setting.camp_start + 1.day + 10.hours,
                          groups_only: true

cleaning_group = Group.create! name: 'WC-Putzer', leader: robi
cleaning_group.users << simi
cleaning_group.users << andi
cleaning_group.events.create! owner: robi,
                              category: c,
                              title: 'WC Putzen',
                              teaser: 'Putzy putzy!',
                              description: 'Muss alles sauber sein!',
                              starts: Setting.camp_end + 10.hours,
                              ends: Setting.camp_end + 12.hours,
                              groups_only: true
