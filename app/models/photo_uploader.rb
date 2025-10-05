# frozen_string_literal: true

require 'exifr/jpeg'
require 'fastimage'

class PhotoUploader
  include ActiveModel::Model
  include ActiveModel::Attributes

  attr_accessor :images
  attribute :user_id, :integer

  validates :images, :user_id, presence: true
  validate :validate_photos

  def save
    normalize_photos

    return false unless valid?

    Photo.transaction do
      images.each do |image|
        # TODO: perform in bg
        metadata = if FastImage.type(image.tempfile.path) == :jpeg
          EXIFR::JPEG.new(image.tempfile.path).to_hash
        end
        Photo.create!(title: image.original_filename, image:, user_id:, metadata:)
      end
    end
    true
  rescue StandardError => e
    Rails.logger.error("Failed to upload photos: #{e.message}")
    errors.add(:base, 'Failed to save photos')
    false
  end

  private

  def validate_photos
    return errors.add(:images, 'must be attached') if images.blank?

    unless images.is_a?(Array)
      errors.add(:images, 'must be an array')
      return
    end

    if images.any? { |image| image.nil? || !image.respond_to?(:content_type) || !image.content_type.to_s.start_with?('image/') }
      errors.add(:images, 'must be image files')
    end
  end

  def normalize_photos
    # If a single file was submitted, wrap it in an array. Ensure we always
    # work with an Array instance (helps when params parser returns
    # ActionController::Parameters or nil).
    if images.respond_to?(:to_unsafe_h)
      # ActionController::Parameters case - convert to plain hash/array if needed
      @images = images.to_unsafe_h
    end

    @images = Array(images).reject(&:blank?)
  end
end
