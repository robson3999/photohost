# frozen_string_literal: true

class Photo < ApplicationRecord
  belongs_to :user
  has_one_attached :image
end
