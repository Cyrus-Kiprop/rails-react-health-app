require 'rails_helper'

RSpec.describe "Measurements", type: :request do
  let(:user) { create(:user) }
  let!(:measure) { create(:todo) }
  let!(:measurement) { create_list(:measurement, 20, measure_id: measure.id) }
  let(:measure_id) { measure.id }
  let(:id) { measurement.first.id }
  let(:headers) { valid_headers }

  # Test suite for GET /measures/:measure_id/items
  describe 'GET /measures/:measure_id/items' do
    before { get "/measures/#{measure_id}/items", params: {}, headers: headers }

    context 'when measure exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all todo items' do
        expect(json.size).to eq(20)
      end
    end

    context 'when measure does not exist' do
      let(:measure_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  end
end
