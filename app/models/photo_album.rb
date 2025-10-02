# frozen_string_literal: true

class PhotoAlbum < ApplicationRecord
  belongs_to :photo
  belongs_to :album

  validates :photo_id, presence: true
  validates :album_id, presence: true
end
