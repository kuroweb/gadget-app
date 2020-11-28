class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :uid, :profile, :avatar_url

  has_many :posts do
    object.posts.with_attached_images
  end
  has_many :following
  has_many :followers
end
