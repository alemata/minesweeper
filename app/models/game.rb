class Game < ApplicationRecord
  has_many :tiles

  after_create :setup_game

  def setup_game
    self.rows ||= 10
    self.columns ||= 10
    self.mines_count ||= 4
    rows.times do |row|
      columns.times do |column|
        tiles << Tile.create(row: row, column: column)
      end
    end
    add_mines
    #TODO update tile neighbor mines count
  end

  def add_mines
    to_add_mines = tiles.sample(mines_count)
    to_add_mines.each do |tile|
      tile.update(mine: true)
    end
  end
end
