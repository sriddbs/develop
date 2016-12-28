class Api::V1::BaseController < ApplicationController
  API_TOKEN = "da0feda374beb6b3c2dde5e71e68888e"

  skip_before_filter :verify_authenticity_token
  skip_before_filter :authenticate_user!

  before_action :authenticate_api_request

  private
    def authenticate_api_request
      authenticate_or_request_with_http_token do |token, options|
        token == API_TOKEN
      end
    end
end