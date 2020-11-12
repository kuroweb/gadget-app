class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :images_url
  belongs_to :user
end
