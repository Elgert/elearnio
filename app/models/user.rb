class User < ApplicationRecord
  include ::PublicId

  has_many :courses
  has_many :enrollments

  ### Validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true

  before_destroy :update_courses_info

  def update_courses_info
    random_other_author_id = User.where.not(author_id: id).pluck(:id).sample
    Course.where(author_id: id).update_all(author_id: random_other_author_id)
  end
end
