class WelcomeController < ApplicationController
  def index
    @posts = PostEntry.paginate(:page => params[:page]).order('post_id DESC').order('updated_at DESC')
  end
end
