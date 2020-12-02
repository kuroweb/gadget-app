class PostSerializer < ActiveModel::Serializer
  attributes :id, :description, :images_url, :created_at
end
