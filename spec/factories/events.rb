# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    owner factory: :user
    category
    title 'Gardening'
    description 'Gardening in the backyard'
    meeting_point 'Backyard'
    starts Setting.camp_start + 1.day + 8.hours
    ends Setting.camp_start + 1.day + 12.hours
    mandatory false
    groups_only false
  end
end
