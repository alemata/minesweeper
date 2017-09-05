module Minesweeper
  module V1
    class Status < Grape::API
      desc "Retrieves the API Status"
      get "/status" do
        { status: "ok" }
      end
    end
  end
end
