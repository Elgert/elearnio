class User < ApplicationRecord
  include ::PublicId

  has_many :courses, foreign_key: :author_id
  has_many :enrollments

  ### Validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  before_destroy :update_courses_info

  before_save :downcase_fields

  def update_courses_info
    random_other_author_id = User.where.not(id: id).pluck(:id).sample
    Course.where(author_id: id).update_all(author_id: random_other_author_id)
  end

  def downcase_fields
    email.downcase!
  end
end
