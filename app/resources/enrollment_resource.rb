class EnrollmentResource < JSONAPI::Resource
  has_one :course
  has_one :user
end
