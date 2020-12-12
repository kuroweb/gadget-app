class BoardCommentSerializer < ActiveModel::Serializer
  attributes :id, :board_id, :user_id, :description, :reply_comment_id
end
