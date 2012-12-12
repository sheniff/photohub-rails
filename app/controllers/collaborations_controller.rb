class CollaborationsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user,    only: [:accept, :reject]

  def index
    @user = current_user
    @albums = current_user.collaborating_albums.where(collaborations: {status: Collaboration::ACCEPTED_STATUS})
    @invitations = current_user.collaborating_albums.where(collaborations: {status: Collaboration::PENDING_STATUS})
  end

  def pending
    @albums = current_user.collaborating_albums.where(collaborations: {status: Collaboration::PENDING_STATUS})
  end

  def accept
    if @collaboration.update_attribute(:status, Collaboration::ACCEPTED_STATUS)
      flash[:success] = "Joined to album: #{@collaboration.album.title}"
    else
      flash[:error] = "Something went wrong, try later..."
    end
    redirect_to collaborations_url and return
  end

  def reject
    @collaboration.destroy
    flash[:notice] = "You rejected joining the album"
    redirect_to collaborations_url and return
  end

  private

    def correct_user
      @collaboration = current_user.collaborations.find_by_id!(params[:id])
    rescue
      redirect_to root_url
    end

end
