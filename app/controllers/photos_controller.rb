# frozen_string_literal: true

class PhotosController < ApplicationController
  before_action :authenticate_user!

  def index
    @photos = current_user.photos
  end

  def new; end

  def create
    @photo_uploader = PhotoUploader.new(photo_uploader_params)
    if @photo_uploader.save
      redirect_to photos_path, notice: 'Photos uploaded successfully.'
    else
      @photo = current_user.photos.new
      flash.now[:alert] = 'Failed to upload photos. Please ensure all files are images.'
      render :new
    end
  end

  def update
    @photo = current_user.photos.find_by(uuid: params[:uuid])
    if @photo.update(photo_params)
      redirect_to photos_path, notice: 'Photo updated successfully.'
    else
      flash.now[:alert] = 'Failed to update photo.'
      redirect_to photos_path
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:title, :description)
  end

  def photo_uploader_params
    params.require(:photo_uploader).permit(images: []).merge(user_id: current_user.id)
  end
end
