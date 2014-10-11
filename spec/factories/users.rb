# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "MyString"
    firstname "MyString"
    sequence(:email) { |i| "email#{i}@example.org" }
    password "secretpassword"
    admin true
  end
end
