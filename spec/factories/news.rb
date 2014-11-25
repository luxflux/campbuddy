# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :news do
    message "MyString"
    visible_until Time.now + 5.hours
  end
end
