# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :user do
    name "MyString"
    firstname "MyString"
    sequence(:email) { |i| "email#{i}@example.org" }
    password "secretpassword"
    admin true
    cellphone '0441231212'
    birthday '2015-05-04'
  end
end
