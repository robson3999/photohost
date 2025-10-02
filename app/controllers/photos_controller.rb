# frozen_string_literal: true

class PhotosController < ApplicationController
  before_action :authenticate_user!

  def index
    @photos = current_user.photos
  end

  def new
    @photo = current_user.photos.new
  end

  def create
    photo = current_user.photos.new(photo_params)
    if photo.save
      redirect_to photos_path, notice: 'Photo uploaded successfully.'
    else
      render :new, alert: 'Failed to upload photo.'
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:title, :description, :image)
  end
end
