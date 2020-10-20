class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :profile
end
