class StaticPagesController < ApplicationController
  def home
    @album = current_user.albums.build if signed_in?
  end

  def help
  end

  def contact
  end
end
