# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :group do
    name 'Chillers & Grillers'
    leader factory: :user
    order 10
  end
end
