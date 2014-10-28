# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    owner factory: :user
    category
    title 'Gardening'
    description 'Gardening in the backyard'
    meeting_point 'Backyard'
    starts_date Time.current.to_date
    starts_time Time.current
    ends_date Time.current.to_date
    ends_time Time.current + 5.hours
  end
end
