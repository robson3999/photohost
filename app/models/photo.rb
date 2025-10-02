# frozen_string_literal: true

class Photo < ApplicationRecord
  include UuidGenerator

  validates :uuid, presence: true, uniqueness: true
  validates :image, presence: true
  validates :title, presence: true

  belongs_to :user
  has_one_attached :image

  has_many :photo_albums, dependent: :destroy
  has_many :albums, through: :photo_albums

  def shareable_url
    Rails.application.routes.url_helpers.rails_blob_url(image, only_path: false)
  end
end
