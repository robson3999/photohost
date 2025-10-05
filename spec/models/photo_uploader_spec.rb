# frozen_string_literal: true

require 'rails_helper'

describe PhotoUploader, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:image) { fixture_file_upload('test.jpg', 'image/jpeg') }
  let(:invalid_image) { fixture_file_upload('test.txt', 'text/plain') }

  describe 'validations' do
    it 'is valid with valid attributes' do
      uploader = PhotoUploader.new(images: [ image ], user_id: user.id)
      expect(uploader).to be_valid
    end

    it 'is invalid without images' do
      uploader = PhotoUploader.new(images: nil, user_id: user.id)
      expect(uploader).not_to be_valid
      expect(uploader.errors[:images]).to include('must be attached')
    end

    it 'is invalid without user_id' do
      uploader = PhotoUploader.new(images: [ image ], user_id: nil)
      expect(uploader).not_to be_valid
      expect(uploader.errors[:user_id]).to include("can't be blank")
    end

    it 'is invalid with non-array images' do
      uploader = PhotoUploader.new(images: image, user_id: user.id)
      expect(uploader).not_to be_valid
      expect(uploader.errors[:images]).to include('must be an array')
    end

    it 'is invalid with non-image files' do
      uploader = PhotoUploader.new(images: [ invalid_image ], user_id: user.id)
      expect(uploader).not_to be_valid
      expect(uploader.errors[:images]).to include('must be image files')
    end
  end

  describe '#save' do
    context 'with valid attributes' do
      it 'saves photos and returns true' do
        uploader = PhotoUploader.new(images: [ image ], user_id: user.id)
        expect(uploader.save).to be true
        expect(Photo.count).to eq(1)
        photo = Photo.last
        expect(photo.user_id).to eq(user.id)
        expect(photo.title).to eq('test.jpg')
        expect(photo.image).to be_attached
      end
    end

    context 'with invalid attributes' do
      it 'does not save photos and returns false' do
        uploader = PhotoUploader.new(images: [ invalid_image ], user_id: user.id)
        expect(uploader.save).to be false
        expect(Photo.count).to eq(0)
      end
    end
  end
end
