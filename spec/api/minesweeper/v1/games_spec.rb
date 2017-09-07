require "rails_helper"

describe Minesweeper::V1::Games do
  describe "POST /api/games" do
    it "returns a new game" do
      expect do
        post "/api/games", params: { rows: 4, columns: 3, mines_count: 2 }
      end.to change(Game, :count).by(1)
      expect(response).to have_http_status(201)
      r = JSON.parse(response.body)
      expect(r["rows"]).to be_eql 4
      expect(r["columns"]).to be_eql 3
      expect(r["mines_count"]).to be_eql 2
      expect(r["tiles"].count).to be_eql 12
    end
  end

  describe "GET /api/games" do
    it "returns a new game" do
      game = Game.create
      get "/api/games/#{game.id}"
      expect(response).to have_http_status(200)
      r = JSON.parse(response.body)
      expect(r["id"]).to be_eql game.id
    end
  end
end
