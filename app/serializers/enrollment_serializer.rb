class EnrollmentSerializer < ActiveModel::Serializer
  has_one :user, embed_key: :public_id, include: true
  has_one :course, embed_key: :public_id, include: true
end
