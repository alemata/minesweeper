require 'rails_helper'

RSpec.describe Tile, type: :model do
  describe "update_neighbor_mines_count" do
    it "should update neighbor_mines_count" do
      game = Game.create(rows: 4, columns: 3, mines_count: 0)
      t1 = game.tiles.find_by(row: 2, column: 1)
      t2 = game.tiles.find_by(row: 3, column: 0)
      t1.add_mine!
      t2.add_mine!
      t3 = game.reload.tiles.find_by(row: 2, column: 0)
      t3.update_neighbor_mines_count
      expect(t3.reload.neighbor_mines_count).to eql 2
      t4 = game.reload.tiles.find_by(row: 1, column: 0)
      t4.update_neighbor_mines_count
      expect(t4.reload.neighbor_mines_count).to eql 1
    end
  end

  describe "reveal" do
    it "should reveal adjacents if neighbor_mines_count == 0" do
      game = Game.create(rows: 4, columns: 3, mines_count: 0)
      game.tiles.find_by(row: 2, column: 1).add_mine!
      game.tiles.find_by(row: 3, column: 0).add_mine!
      game.tiles.find_by(row: 2, column: 2).add_mine!
      game.reload.update_tiles_neighbor_mines

      game.reload.tiles.find_by(row: 0, column: 0).reveal!
      revealed = game.reload.tiles.select(&:revealed?).count
      expect(revealed).to eql 6
    end

    it "should not reveal adjacents if neighbor_mines_count > 0" do
      game = Game.create(rows: 4, columns: 3, mines_count: 0)
      game.tiles.find_by(row: 2, column: 1).add_mine!
      game.tiles.find_by(row: 3, column: 0).add_mine!
      game.tiles.find_by(row: 2, column: 2).add_mine!
      game.reload.update_tiles_neighbor_mines

      game.reload.tiles.find_by(row: 2, column: 2).reveal!
      revealed = game.reload.tiles.select(&:revealed?).count
      expect(revealed).to eql 1
    end
  end

  describe "toggle_flagged" do
    it "set flagged when no flagged" do
      game = Game.create(rows: 4, columns: 3, mines_count: 0)
      tile = game.tiles.first
      tile.toggle_flagged!
      expect(tile.flagged).to be_truthy
    end

    it "set no flagged when flagged" do
      game = Game.create(rows: 4, columns: 3, mines_count: 0)
      tile = game.tiles.first
      tile.update(flagged: true)
      tile.toggle_flagged!
      expect(tile.flagged).to be_falsy
    end
  end
end
