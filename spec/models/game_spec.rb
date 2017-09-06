require 'rails_helper'

RSpec.describe Game, type: :model do
  describe "creation" do
    it "creates tiles and add bombs" do
      game = Game.create(rows: 3, columns: 3, mines_count: 2)
      expect(game.tiles.count).to eql 9
      tiles_with_mines = game.tiles.select(&:mine?).count
      expect(tiles_with_mines).to eql 2
    end
  end
end
