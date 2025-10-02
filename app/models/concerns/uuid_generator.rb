# frozen_string_literal: true

module UuidGenerator
  extend ActiveSupport::Concern

  included do
    before_validation :assign_uuid
  end

  private

  def assign_uuid
    self.uuid = SecureRandom.uuid if uuid.blank?
  end
end
