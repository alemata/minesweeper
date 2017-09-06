module Minesweeper
  module V1
    class Tiles < Grape::API
      resource :games do
        segment '/:game_id' do
          resource :tiles do
            desc "Reveals a tile"
            post '/:id/reveal' do
              game = Game.find(params[:game_id])
              tile = game.tiles.find(params[:id])
              game.reveal(tile)
            end

            desc "Toggles the flagged attribute"
            post '/:id/toggle_flag' do
              game = Game.find(params[:game_id])
              tile = game.tiles.find(params[:id])
              tile.toggle_flagged!

              tile
            end
          end
        end
      end
    end
  end
end
