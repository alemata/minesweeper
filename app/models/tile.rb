class Tile < ApplicationRecord
  belongs_to :game

  def update_neighbor_mines_count
    mines_count = game.neighbors_for(self).select { |t| t.mine }.size
    update(neighbor_mines_count: mines_count)
  end

  def add_mine!
    update(mine: true)
  end

  def reveal!
    return if revealed
    update(revealed: true)
    if !mine && neighbor_mines_count.zero?
      game.neighbors_for(self).map(&:reveal!)
    end
  end
end
