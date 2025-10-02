# frozen_string_literal: true

require 'rails_helper'

describe Photo, type: :model do
  let(:user) { FactoryBot.create(:user) }

  it 'assigns a uuid before creation' do
    photo = Photo.new(user: user, image: fixture_file_upload('test.jpg', 'image/jpeg'))
    expect(photo.uuid).to be_nil
    photo.save!
    expect(photo.uuid).to be_present
    expect(photo.uuid).to match(/[0-9a-fA-F\-]{36}/)
  end
end
