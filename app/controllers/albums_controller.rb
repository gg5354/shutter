class AlbumsController < ApplicationController
  prepend_before_filter :authenticate_user!

  def index
    @albums = Album.where(user_id: current_user.id)
  end
end
