module Minesweeper
  class API < Grape::API
    mount Minesweeper::V1::All
  end
end
