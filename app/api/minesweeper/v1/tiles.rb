module Minesweeper
  module V1
    class Tiles < Grape::API
      resource :games do
        segment '/:game_id' do
          resource :tiles do
            post '/:id/reveal' do
              game = Game.find(params[:game_id])
              tile = game.tiles.find(params[:id])
              game.reveal(tile)
            end
          end
        end
      end
    end
  end
end
