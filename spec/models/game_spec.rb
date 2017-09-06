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
end
