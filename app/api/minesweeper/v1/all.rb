module Minesweeper
  module V1
    class All < Grape::API
      version "v1", using: :accept_version_header
      format :json

      # global exception handler, used for error notifications
      rescue_from :all do |e|
        raise e if Rails.env.development? || Rails.env.test?
        Rails.logger.error(e.message)
        Rails.logger.error(e.backtrace.join("\n"))
        error_response(message: "Internal server error", status: 500)
      end

      default_format :json

      mount Minesweeper::V1::Status
    end
  end
end
