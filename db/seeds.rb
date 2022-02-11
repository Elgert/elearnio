# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = []
courses = []
1000.times do
  users << User.create({
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.safe_email,
  })
end

20.times do
  courses << Course.create({
    name: Faker::ProgrammingLanguage.name,
    description: Faker::ProgrammingLanguage.creator,
    category: %w[marketing sales logistics].sample,
    author_id: users.pluck(:id).sample
  })
end

200.times do
  Enrollment.create({
    course_id: courses.pluck(:id).sample,
    user_id: users.pluck(:id).sample
  })
end
