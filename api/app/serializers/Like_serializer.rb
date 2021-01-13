class LikeSerializer < ActiveModel::Serializer
  attributes :id, :post_id, :user_id
end