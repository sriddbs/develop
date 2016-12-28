class Api::V1::LinksApiController < Api::V1::BaseController
  def generate_short_url
    render json: { errors: "Missing required parameter URL" }, status: 400 and return if params[:url].blank?
    render json: { errors: "Shortened URL is already present for the given url" }, status: 400 and return if Link.find_by(actual_url: params[:url]).present?

    @link = Link.new(actual_url: params[:url])
    @link.key = Link.generate_key
    @link.short_url = @link.generate_short_url
    if @link.save
      render json: { short_url: @link.short_url }, status: 200
    else
      render json: { errors: @link.errors.full_messages.to_sentence }, status: 422
    end
  end

  def get_statistics
    render json: { errors: "Missing required parameter URL" }, status: 400 and return if params[:url].blank?
    render json: { errors: "Could not find the link" }, status: 422 and return unless @link = Link.find_by(short_url: params[:url])

    @stats = []
    UserUrlVisit.where(link_id: @link).group_by(&:user_id).map { |user_id, visits|
      user = User.find user_id
      @stats << {
        email: user.email,
        ip_address: user.last_sign_in_ip.to_s,
        visit_count: visits.count,
        last_visited_at: visits.last.created_at.strftime("%d %b, %H:%M %P")
      }
    }

    render json: { user_stats: @stats }
  end
end