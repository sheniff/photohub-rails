class AlbumsController < ApplicationController
  before_filter :signed_in_user,  only: [:create, :destroy]
  before_filter :correct_user,    only: :destroy
  def create
    @album = current_user.albums.build(params[:album])
    if @album.save
      flash[:success] = "Album created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @album.destroy
    redirect_to root_url
  end

  private

    def correct_user
      @album = current_user.albums.find_by_id(params[:id])
    rescue
      redirect_to root_url
    end

end
