class WelcomeController < ApplicationController
  def index
    @posts = PostEntry.paginate(:page => params[:page]).order(:post_id, :updated_at)
  end
end
