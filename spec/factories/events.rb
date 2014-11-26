# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    owner factory: :user
    category
    title 'Gardening'
    description 'Gardening in the backyard'
    meeting_point 'Backyard'
    starts Time.current + 1.day
    ends Time.current + 1.day + 4.hours
    mandatory false
    groups_only false
  end
end
