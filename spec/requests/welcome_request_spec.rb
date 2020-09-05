require 'rails_helper'

RSpec.describe "Welcomes", type: :request do
  # Test suite for GET /
  describe 'GET /measures' do
    # make HTTP get request before each example
    before { get '/', params: {} }

    it 'returns welcome page' do
      # Note `json` is a custom helper to parse JSON responses
      expect(response.body).to match("{\"message\":\"Welcome to our Health App api\"}")
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

end
