class AlbumsController < ApplicationController
  before_filter :signed_in_user

  def create
    @album = current_user.albums.build(params[:album])
    if @album.save
      flash[:success] = "Album created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
  end
end
