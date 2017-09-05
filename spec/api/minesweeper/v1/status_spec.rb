require "rails_helper"

describe Minesweeper::V1::Status do
  describe "GET /api/status" do
    it "returns ok" do
      get "/api/status"
      expect(response).to have_http_status(200)
      r = JSON.parse(response.body)
      expect(r["status"]).to be_eql "ok"
    end
  end
end
