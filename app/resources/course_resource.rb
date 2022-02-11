class CourseResource < JSONAPI::Resource
  attributes :name, :description, :category
  has_one :user, foreign_key: :author_id
  has_many :enrollments
end
