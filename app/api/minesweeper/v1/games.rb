module Minesweeper
  module V1
    class Games < Grape::API
      resource :games do
        # POST /games
        desc "Creates a new game"
        params do
          optional :rows, type: Integer,
                   desc: "Number of rows"
          optional :columns, type: Integer,
                   desc: "Number of columns"
          optional :mines_count, type: Integer,
                   desc: "Number of mines"
        end
        post do
          Game.create(params)
        end

        # GET /games/:id
        desc 'Returns a game.'
        params do
          requires :id, type: Integer, desc: 'Game id.'
        end
        route_param :id do
          get do
            Game.find(params[:id])
          end
        end
      end
    end
  end
end
