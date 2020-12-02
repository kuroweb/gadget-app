class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :uid, :profile, :avatar_url
end
