class UserSerializer < ActiveModel::Serializer
  attributes :first_name,
             :last_name,
             :full_name,
             :email

  def full_name
    "#{object.first_name} #{object.last_name}"
  end
end
