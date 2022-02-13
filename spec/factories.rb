FactoryBot.use_parent_strategy = false

FactoryBot.define do
  factory :user, class: 'User' do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.safe_email }
  end

  factory :course, class: 'Course' do
    name { Faker::ProgrammingLanguage.name }
    description { Faker::ProgrammingLanguage.creator }
    category { %w[marketing sales logistics].sample }
    user
  end

  factory :enrollment, class: 'Enrollment' do
    course
    user
  end
end
