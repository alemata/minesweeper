class TileSerializer < ActiveModel::Serializer
  attributes :id, :row, :column, :bomb, :revealed, :neighbor_mines_count
end
