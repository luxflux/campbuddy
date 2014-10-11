# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    owner factory: :user
    category
    title 'Gardening'
    description 'Gardening in the backyard'
    meeting_point 'Backyard'
    starts Time.now - 1.week
    ends Time.now - 1.week + 5.hours
  end
end
