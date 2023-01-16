require 'rails_helper'

RSpec.describe 'Songs', type: :request do
  describe 'GET /show' do
    context 'when there are no songs' do
      it 'returns http success' do
        get '/songs'
        expect(response).to have_http_status(:success)
      end
    end

    context 'when there is a song' do
      before do
        Song.create
      end

      it 'returns http success' do
        get '/songs'
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET /show/:id' do
    let(:song) { Song.create(container: 'flagon') }

    context 'when an incorrect id is passed' do
      it 'returns 404' do
        get "/songs/#{song.id + 1}"
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when a correct id is passed' do
      let(:path) { "/songs/#{song.id}" }

      it 'returns http success' do
        get path
        expect(response).to have_http_status(:success)
      end

      it 'accepts parameters' do
        get path, params: { start_verse: 66, song_length: 10 }
        expect(response).to have_http_status(:success)
      end

      it 'uses parameters to generate the verses' do
        get path, params: { start_verse: 66, song_length: 1 }

        expect(response).to have_http_status(:success)
        expect(response.body).not_to include('67 flagons of beer on the wall,')
        expect(response.body).to include('66 flagons of beer on the wall,')
        expect(response.body).not_to include('65 flagons of beer on the wall,')
      end
    end
  end
end
