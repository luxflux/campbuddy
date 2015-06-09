FactoryGirl.define do
  factory :camp do
    organization
    name "example camp"
    subdomain "127"
    hashtag 'examplecamp'
    starts Time.now + 1.week
    ends Time.now + 2.weeks
    registration_opens Time.now + 3.days
    welcome_text 'LALA!'
  end
end
