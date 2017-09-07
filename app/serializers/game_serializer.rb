class GameSerializer < ActiveModel::Serializer
  attributes :id, :rows, :columns, :status, :mines_count
  has_many :tiles
end
