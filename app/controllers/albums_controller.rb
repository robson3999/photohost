# frozen_string_literal: true

class AlbumsController < ApplicationController
  before_action :authenticate_user!

  def index
    @albums = current_user.albums
  end

  def new
    @album = current_user.albums.new
  end

  def create
    @album = current_user.albums.new(album_params.except(:photos))
    if @album.save
      if album_params[:photos]
        @album.photos = current_user.photos.where(uuid: album_params[:photos])
      end
      redirect_to albums_path, notice: 'Album created successfully.'
    else
      render :new, alert: 'Failed to create album.'
    end
  end

  def show
    @album = current_user.albums.find_by(uuid: params[:uuid])
  end

  def destroy
    album = current_user.albums.find_by(uuid: params[:uuid])
    album.destroy
    redirect_to albums_path, notice: 'Album deleted successfully.'
  end

  private

  def album_params
    params.require(:album).permit(:title, :description, photos: [])
  end
end
