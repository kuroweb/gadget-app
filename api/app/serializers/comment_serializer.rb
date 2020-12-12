class CommentSerializer < ActiveModel::Serializer
  attributes :id, :post_id, :user_id, :reply_comment_id
end
