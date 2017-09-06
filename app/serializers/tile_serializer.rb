class TileSerializer < ActiveModel::Serializer
  attributes :id, :row, :column, :mine, :revealed,
             :neighbor_mines_count, :flagged
end
