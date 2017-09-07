require "rails_helper"

describe Minesweeper::V1::Tiles do
  describe "POST /api/games/:game_id/tiles/:id/reveal" do
    it "returns the new game with the tile(s) reveales" do
      game = Game.create(rows: 4, columns: 3, mines_count: 0)
      game.tiles.find_by(row: 2, column: 1).add_mine!
      game.tiles.find_by(row: 3, column: 0).add_mine!
      game.tiles.find_by(row: 2, column: 2).add_mine!
      game.reload.update_tiles_neighbor_mines

      tile = game.reload.tiles.find_by(row: 0, column: 0)
      post "/api/games/#{game.id}/tiles/#{tile.id}/reveal"
      r = JSON.parse(response.body)
      revealed_count = r["tiles"].select { |t| t["revealed"] }.count
      expect(revealed_count).to be_eql 6
      expect(r["status"]).to be_eql "started"
    end
  end

  describe "POST /api/games/:game_id/tiles/:id/toggle_flag" do
    it "toggle the flagged tile attribute" do
      game = Game.create(rows: 4, columns: 3, mines_count: 0)

      tile = game.tiles.first
      post "/api/games/#{game.id}/tiles/#{tile.id}/toggle_flag"
      r = JSON.parse(response.body)
      require 'pry'; binding.pry
      expect(r["flagged"]).to be true
    end

    it "toggle the flagged tile attribute for flagged tile" do
      game = Game.create(rows: 4, columns: 3, mines_count: 0)

      tile = game.tiles.first
      tile.update(flagged: true)
      post "/api/games/#{game.id}/tiles/#{tile.id}/toggle_flag"
      r = JSON.parse(response.body)
      expect(r["flagged"]).to be false
    end
  end
end
