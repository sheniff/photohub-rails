class PicturesController < ApplicationController
  before_filter :signed_in_user,  only: [:new, :create, :destroy]
  before_filter :correct_user,    only: [:edit, :update, :destroy]
  before_filter :album_owner,     only: [:new, :create]

  def new
    @picture = Picture.new
  end

  def create
    @picture = @album.pictures.build(params[:picture])
    @picture.user = current_user
    if @picture.save
      flash[:success] = "New picture added: #{@picture.name}"
      redirect_to @album
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @picture.update_attributes(params[:picture])
      flash[:success] = "Name updated!"
      redirect_to @picture.album
    else
      render 'edit'
    end
  end

  def destroy
    @picture.destroy
    redirect_to @picture.album
  end

  private

    def correct_user
      @picture = current_user.pictures.find_by_id(params[:id])
    rescue
      redirect_to root_url
    end

    def album_owner
      @album = current_user.albums.find_by_id(params[:album_id])
    rescue
      redirect_to root_url
    end

end
