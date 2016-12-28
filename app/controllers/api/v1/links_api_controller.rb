class Api::V1::LinksApiController < Api::V1::BaseController
  def generate_short_url
    render json: { errors: "Missing required parameter URL" }, status: 400 and return if params[:url].blank?
    render json: { errors: "Shortened URL is already present for the given url" }, status: 400 and return if Link.find_by(actual_url: params[:url]).present?

    @link = Link.new(actual_url: params[:url])
    @link.key = Link.generate_key
    if @link.save
      render json: { short_url: @link.short_url }, status: 200
    else
      render json: { errors: @link.errors.full_messages.to_sentence }, status: 422
    end
  end
end