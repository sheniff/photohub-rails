class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @album = current_user.albums.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def contact
  end
end
