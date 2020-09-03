require 'rails_helper'

RSpec.describe "Measures", type: :request do
 # initialize test data
  let!(:user) { create(:user) }
  let!(:measures) { create_list(:measure, 10, user_id: user.id) }
  let(:measure_id) { measures.first.id }

  # Test suite for GET /measures
  describe 'GET /measures' do
    # make HTTP get request before each example
    before { get '/measures' }

    it 'returns measures' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /measures/:id
  describe 'GET /measures/:id' do
    before { get "/measures/#{measure_id}" }

    context 'when the record exists' do
      it 'returns the todo' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(measure_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:measure_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  end

  # Test suite for POST /measures
  describe 'POST /measures' do
    # valid payload
    let(:valid_attributes) { { user_id: 1 } }

    context 'when the request is valid' do
      before { post '/measures', params: valid_attributes }

      it 'creates a todo' do
        expect(json['user_id']).to eq( 1 )
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/measures', params: {  } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: User_id can't be blank/)
      end
    end
  end

  # Test suite for DELETE /measures/:id
  describe 'DELETE /measures/:id' do
    before { delete "/measures/#{measure_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
