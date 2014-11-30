# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :group do
    name 'Chillers & Grillers'
    leader factory: :user
  end
end
