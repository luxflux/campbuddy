# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :workshop do
    owner factory: :user
    starts Time.now - 1.week
    ends Time.now - 1.week + 5.hours
    title 'Gardening'
    description 'Gardening in the backyard'
  end
end
