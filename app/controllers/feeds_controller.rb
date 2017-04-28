class FeedsController < ApplicationController

  def index
    @posts = current_user.posts_in_feeds
  end
end
