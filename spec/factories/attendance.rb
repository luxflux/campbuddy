# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :attendance do
    user
    event
  end
end
