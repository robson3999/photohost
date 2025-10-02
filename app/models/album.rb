# frozen_string_literal: true

class Album < ApplicationRecord
  belongs_to :user

  has_many :photo_albums, dependent: :destroy
  has_many :photos, through: :photo_albums

  validates :title, presence: true

  scope :private, -> { where(private: true) }
  scope :public, -> { where(private: false) }
end
