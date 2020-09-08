require 'rails_helper'

RSpec.describe 'Measures', type: :request do
  # initialize test data
  let(:user) { create(:user) }
  let(:admin) { create(:user, admin: true) }
  let!(:measures) { create_list(:measure, 10, user_id: user.id) }
  let(:measure_id) { measures.first.id }

  # authorize_request
  let(:headers) { valid_headers(user.id) }

  # Test suite for GET /measures
  describe 'GET /measures' do
    # make HTTP get request before each example
    before { get '/measures', params: {}, headers: headers }

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
    before { get "/measures/#{measure_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the measure item' do
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
        expect(response.body).to match(
          "{\"message\":\"Couldn't find Measure with 'id'=100\"}"
        )
      end
    end
  end

  # Test suite for POST /measures
  describe 'POST /measures' do
    # valid payload
    let(:valid_attributes) do
      { body_part_name: 'Thighs' }.to_json
    end

    context 'when non-admin users try to access this endpoint' do
      before { post '/measures', params: valid_attributes, headers: valid_headers(user.id) }

      it 'return unauthorized request' do
        expect(response.body).to match('{"message":"Unauthorized request"}')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(422)
      end
    end

    let(:headers) { valid_headers(admin.id) }

    context 'when the request is valid' do
      before { post '/measures', params: valid_attributes, headers: headers }

      it 'creates a todo' do
        expect(json['user_id']).to eq(admin.id)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { {}.to_json }

      before { post '/measures', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match("{\"message\":\"Validation failed: Body part name can't be blank\"}")
      end
    end
  end

  # Test suite for DELETE /measures/:id
  describe 'DELETE /measures/:id' do
    let(:headers) { valid_headers(admin.id) }
    before { delete "/measures/#{measure_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
