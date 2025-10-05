# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Photos', type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { FactoryBot.create(:user) }

  let(:valid_params) do
    {
      photo_uploader: {
        images: [
          fixture_file_upload(Rails.root.join('spec/fixtures/files/test.jpg'), 'image/jpeg')
        ]
      }
    }.with_indifferent_access
  end

  let(:invalid_params) do
    {
      photo_uploader: {
        images: [ nil ]
      }
    }.with_indifferent_access
  end

  before do
    sign_in user
  end

  describe 'POST /photos' do
    it 'creates a photo with valid params' do
      expect {
        post photos_path, params: valid_params
      }.to change(Photo, :count).by(1)
      expect(response).to redirect_to(photos_path)
      follow_redirect!
      expect(response.body).to match(/Photos uploaded successfully/)
    end

    it 'does not create a photo with invalid params and returns error' do
      expect {
        post photos_path, params: invalid_params
      }.not_to change(Photo, :count)
      expect(response).to have_http_status(:ok)
      expect(response.body).to match(/Failed to upload photos|must be an array|must be image files/i)
    end
  end
end
