class BoardSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :description, :title, :board_type
end
