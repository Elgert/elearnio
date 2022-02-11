class Course < ApplicationRecord
  include ::PublicId

  belongs_to :author

  has_many :enrollments

  ### Validations
  validates :author_id, presence: true
  validates :name, presence: true
  validates :category, inclusion: {
    in: %w(marketing sales logistics),
    allow_nil: false,
    message: 'invalid course category'
  }
end
