class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :images_url, :created_at
  belongs_to :user
end
