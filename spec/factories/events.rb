# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    owner factory: :user
    category
    title 'Gardening'
    teaser 'Garending, yeah!'
    description 'Gardening in the backyard'
    meeting_point 'Backyard'
    starts { |event| Setting.camp_starts + 1.day }
    ends { |event| Setting.camp_ends - 1.day }
    groups_only false
  end
end
