class Tile < ApplicationRecord
  belongs_to :game

  def update_neighbor_mines_count
    mines_count = game.neighbors_for(self).select { |t| t.mine }.size
    update(neighbor_mines_count: mines_count)
  end

  def add_mine!
    update(mine: true)
  end
end
