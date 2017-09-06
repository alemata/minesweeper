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
end
