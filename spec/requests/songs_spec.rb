require 'rails_helper'

RSpec.describe 'Songs', type: :request do
  describe 'GET /show' do
    it 'returns http success' do
      get '/songs/show'
      expect(response).to have_http_status(:success)
    end

    it 'accepts parameters' do
      get '/songs/show', params: { start_verse: 66, song_length: 10 }
      expect(response).to have_http_status(:success)
    end

    it 'uses parameters to generate the verses' do
      get '/songs/show', params: { start_verse: 66, song_length: 1 }

      expect(response).to have_http_status(:success)
      expect(response.body).not_to include('67 bottles of beer on the wall,')
      expect(response.body).to include('66 bottles of beer on the wall,')
      expect(response.body).not_to include('65 bottles of beer on the wall,')
    end
  end
end
