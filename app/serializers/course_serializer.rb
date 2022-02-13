class CourseSerializer < ActiveModel::Serializer
  attributes :name,
             :description,
             :category

  has_one :user, key: :author, foreign_key: 'author_id', embed_key: :public_id, include: true
end
