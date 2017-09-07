class Game < ApplicationRecord
  has_many :tiles

  after_create :setup_game

  def setup_game
    self.rows ||= 6
    self.columns ||= 5
    self.mines_count ||= 4
    self.status = :started
    self.save
    rows.times do |row|
      columns.times do |column|
        tiles << Tile.create(row: row, column: column)
      end
    end
    add_mines
  end

  def reveal(tile)
    tile.reveal!
    update(status: :lost) if tile.mine
    update(status: :won) if win?

    self
  end

  def win?
    revealed = tiles.where(mine: false, revealed: true)
    revealed.count == tiles.count - mines_count
  end

  def add_mines
    to_add_mines = tiles.sample(mines_count)
    to_add_mines.each(&:add_mine!)

    update_tiles_neighbor_mines
  end

  # Update tiles neighbor_mines_count for all tiles
  def update_tiles_neighbor_mines
    tiles.map(&:update_neighbor_mines_count)
  end

  def neighbors_for(tile)
    tiles.select do |t|
      (tile.row - t.row).abs <= 1 &&
        (tile.column - t.column).abs <= 1 &&
        tile != t
    end
  end
end
