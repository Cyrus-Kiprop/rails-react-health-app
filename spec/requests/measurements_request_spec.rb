require 'rails_helper'

RSpec.describe 'Measurements', type: :request do
  let(:user) { create(:user) }
  let!(:measure) { create(:measure, user_id: user.id) }
  let!(:measurement) { create_list(:measurement, 20, measure_id: measure.id) }
  let(:measure_id) { measure.id }
  let(:id) { measurement.first.id }
  let(:headers) { valid_headers }

  # Test suite for GET /measures/:measure_id/measurements
  describe 'GET /measures/:measure_id/measurements' do
    before { get "/measures/#{measure_id}/measurements", params: {}, headers: headers }

    context 'when measure exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all measure measurements' do
        expect(json.size).to eq(20)
      end
    end

    context 'when measure does not exist' do
      let(:measure_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match("{\"message\":\"Couldn't find Measure with 'id'=0\"}")
      end
    end
  end

  # Test suite for GET /measures/:measure_id/measurements/:id
  describe 'GET /measures/:measure_id/measurements/:id' do
    before { get "/measures/#{measure_id}/measurements/#{id}", params: {}, headers: headers }

    context 'when measure measurement exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the measurement' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when measure measurement does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Measure/)
      end
    end
  end

  # Test suite for POST /measures/:measure_id/measurements
  describe 'POST /measures/:measure_id/measurements' do
    let(:valid_attributes) { { size: 4 }.to_json }

    context 'when request attributes are valid' do
      before { post "/measures/#{measure_id}/measurements", params: valid_attributes, headers: headers}

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/measures/#{measure_id}/measurements", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Size can't be blank/)
      end
    end
  end

  # Test suite for PUT /measures/:measure_id/measurements/:id
  describe 'PUT /measures/:measure_id/measurements/:id' do
    let(:valid_attributes) { { size: 67 }.to_json }

    before { put "/measures/#{measure_id}/measurements/#{id}", params: valid_attributes, headers: headers }

    context 'when measurement exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the measurement' do
        updated_measurement = Measurement.find(id)
        expect(updated_measurement.size).to match(/67/)
      end
    end

    context 'when the measurement does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(+"{\"message\":\"Couldn't find Measurement with [WHERE \\\"measurements\\\".\\\"measure_id\\\" = $1 AND \\\"measurements\\\".\\\"id\\\" = $2]\"}")
      end
    end
  end

  # Test suite for DELETE /measures/:id
  describe 'DELETE /measures/:measure_id/measurements/:id' do
    before { delete "/measures/#{measure_id}/measurements/#{id}", params: {}, headers: headers}

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

end
