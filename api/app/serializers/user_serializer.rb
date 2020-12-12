class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :uid, :profile
end
