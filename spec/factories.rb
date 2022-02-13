FactoryBot.use_parent_strategy = false

FactoryBot.define do
  factory :user, class: 'User' do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.safe_email }
  end
end
