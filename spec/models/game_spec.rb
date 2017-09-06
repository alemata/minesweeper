require 'rails_helper'

RSpec.describe Game, type: :model do
  describe "creation" do
    it "creates tiles and add mines" do
      game = Game.create(rows: 3, columns: 3, mines_count: 2)
      expect(game.tiles.count).to eql 9
      tiles_with_mines = game.tiles.select(&:mine?).count
      expect(tiles_with_mines).to eql 2
    end

    it "calculate the neighbor_mines_count and update tiles" do
      game = Game.create(rows: 3, columns: 3, mines_count: 0)
      t1 = game.tiles.find_by(row: 0, column: 0)
      t1.add_mine!
      game.reload.update_tiles_neighbor_mines
      t2 = game.reload.tiles.find_by(row: 0, column: 1)
      expect(t2.neighbor_mines_count).to eql 1
    end
  end

  describe "reveal" do
    it "should set lost status when revealing a mine" do
      game = Game.create(rows: 2, columns: 2, mines_count: 0)
      game.tiles.find_by(row: 0, column: 0).add_mine!
      game.reload.update_tiles_neighbor_mines

      tile = game.reload.tiles.find_by(row: 0, column: 0)
      game.reload.reveal(tile)
      expect(game.reload.status).to eql "lost"
    end

    it "should not change status if not lost and not won" do
      game = Game.create(rows: 2, columns: 2, mines_count: 0)
      game.tiles.find_by(row: 0, column: 0).add_mine!
      game.reload.update_tiles_neighbor_mines

      tile = game.reload.tiles.find_by(row: 0, column: 1)
      game.reload.reveal(tile)
      expect(game.reload.status).to eql "started"
    end

    it "should set won status if won" do
      game = Game.create(rows: 2, columns: 2, mines_count: 0)
      game.tiles.find_by(row: 0, column: 0).add_mine!
      game.reload.update_tiles_neighbor_mines

      tile = game.reload.tiles.find_by(row: 0, column: 1)
      game.reload.reveal(tile)
      tile = game.reload.tiles.find_by(row: 1, column: 0)
      game.reload.reveal(tile)
      tile = game.reload.tiles.find_by(row: 1, column: 1)
      game.reload.reveal(tile)

      expect(game.reload.status).to eql "started"
    end
  end
end
