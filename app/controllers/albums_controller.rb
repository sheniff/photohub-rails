class AlbumsController < ApplicationController
  before_filter :signed_in_user,  except: [:show]
  before_filter :correct_user,    only: [:destroy, :invite, :revoke]
  before_filter :allowed_user,    only: [:collaborators, :invitations]

  def show
    @user = current_user
    @album = Album.find_by_id(params[:id])
  end

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

  def invite
    if current_user == params[:user_id]
      flash[:error] = "Owner can't be invited to the album"
      redirect_to root_url
    end

    @user = User.find_by_id(params[:user_id])
    @album.invite!(@user)
    redirect_to @album
  end

  def revoke
    @user = User.find_by_id(params[:user_id])
    @album.revoke!(@user)
    redirect_to @album
  end

  def collaborators
    @collaborators = @album.collaborators.where(collaborations: {status: Collaboration::ACCEPTED_STATUS});
  end

  def invitations
    @invitations = @album.collaborators.where(collaborations: {status: Collaboration::PENDANT_STATUS});
  end

  private

    def correct_user
      @album = current_user.albums.find_by_id!(params[:id])
    rescue
      redirect_to root_url
    end

    def allowed_user
      @album = current_user.albums.find_by_id(params[:id])
      @album = current_user.collaborating_albums.find_by_id(params[:id]) unless @album
      redirect_to root_url unless @album
    end

end
