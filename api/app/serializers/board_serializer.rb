class BoardSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :description
end
