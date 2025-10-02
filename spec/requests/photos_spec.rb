require 'rails_helper'

RSpec.describe 'Photos', type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { FactoryBot.create(:user) }

  let(:valid_params) do
    {
      photo: {
        title: 'Test Photo',
        image: fixture_file_upload(Rails.root.join('spec/fixtures/files/test.jpg'), 'image/jpeg'),
        description: 'A test photo.'
      }
    }
  end

  let(:invalid_params) do
    {
      photo: {
        title: '',
        image: nil,
        description: 'Missing image and title.'
      }
    }
  end

  before do
    sign_in user
  end

  describe 'POST /photos' do
    it 'creates a photo with valid params' do
      expect {
        post photos_path, params: valid_params
      }.to change(Photo, :count).by(1)
      expect(response).to have_http_status(:created)
      expect(response.body).to match(/Photo uploaded successfully/)
    end

    it 'does not create a photo with invalid params and returns error' do
      expect {
        post photos_path, params: invalid_params
      }.not_to change(Photo, :count)
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to match(/error|invalid|can't be blank/i)
    end
  end
end
