class LinksController < ApplicationController
  def index
    @links = Link.all.reverse_order
  end

  def new
    @link = Link.new
  end

  def create
    if params[:link][:actual_url].blank?
      flash[:error] = "Enter a URL to shorten it"
      redirect_to new_link_path and return
    end
    if @link = Link.find_by(actual_url: params[:link][:actual_url])
      flash[:error] = "Short URL already present for the given url #{@link.short_url}".html_safe
      redirect_to new_link_path and return
    end

    @link = Link.new link_params
    @link.key = Link.generate_key
    if @link.save
      flash[:success] = "Shortened Link successfully created"
      redirect_to links_path
    else
      flash[:error] = @link.errors.full_messages.to_sentence
    end
  end

  def forward
    @link = Link.find_by key: params[:key]
    if @link
      @link.clicks += 1
      @link.save
      redirect_to @link.actual_url
    end
  end

  private
    def link_params
      params.require(:link).permit(:actual_url)
    end
end