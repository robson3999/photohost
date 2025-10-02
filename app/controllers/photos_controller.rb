# frozen_string_literal: true

class PhotosController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: { photos: current_user.photos.map(&:shareable_url) }
  end

  def create
    # binding.pry
    photo = current_user.photos.new(photo_params)
    if photo.save
      render json: { message: 'Photo uploaded successfully', uuid: photo.uuid }, status: :created
    else
      render json: { errors: photo.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:title, :description, :image)
  end
end
