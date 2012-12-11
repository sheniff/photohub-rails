class CollaborationsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user,    only: [:accept, :reject]

  def index
    @albums = current_user.collaborating_albums
  end

  def index
    @albums = current_user.collaborating_albums.where(collaborations: {status: Collaboration::PENDING_STATUS})
  end

  def accept
    if @collaboration.update_attribute(status, Collaboration::ACCEPTED_STATUS)
      flash[:success] = "Joined to album: #{@collaboration.album.title}"
    else
      flash[:error] = "Something went wrong, try later..."
    end
    redirect_to index
  end

  def reject
    @collaboration.destroy
    flash[:notice] = "You rejected joining the album"
    redirect_to index
  end

  private

    def correct_user
      @collaboration = current_user.collaborations.find_by_id!(params[:id])
    rescue
      redirect_to root_url
    end

end
