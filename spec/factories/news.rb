# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :news do
    message "MyString"
    visible_until Time.now + 5.hours
  end
end
