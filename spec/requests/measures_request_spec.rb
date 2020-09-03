require 'rails_helper'

RSpec.describe "Measures", type: :request do
 # initialize test data
  let!(:user) { create(:user) }
  let!(:measurements) { create_list(:measure, 10, user_id: user.id) }
  let(:measure_id) { measurements.first.id }

  # Test suite for GET /measurements
  describe 'GET /measurements' do
    # make HTTP get request before each example
    before { get '/measurements' }

    it 'returns measurements' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /measurements/:id
  describe 'GET /measurements/:id' do
    before { get "/measurements/#{measure_id}" }

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

end
