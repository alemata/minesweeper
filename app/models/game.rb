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
    added = 0
    loop do
      row = rand(rows)
      col = rand(columns)
      tile = tiles.find_by(row: row, column: col)
      if !tile.mine?
        tile.update(mine: true)
        added += 1
      end
      break if added == mines_count
    end
  end
end
