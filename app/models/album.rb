# frozen_string_literal: true

class Album < ApplicationRecord
  include UuidGenerator

  belongs_to :user

  has_many :photo_albums, dependent: :destroy
  has_many :photos, through: :photo_albums

  validates :title, presence: true

  scope :secret, -> { where(private: true) }
  scope :published, -> { where(private: false) }
end
