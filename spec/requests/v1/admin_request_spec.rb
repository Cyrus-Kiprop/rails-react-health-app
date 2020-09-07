require 'rails_helper'

RSpec.describe 'V1::Admins', type: :request do
  # initialize test data
  let(:user) { create(:user) }
  let(:admin) { create(:user, admin: true) }
  let!(:measures) { create_list(:measure, 10, user_id: admin.id) }
  let(:measure_id) { measures.first.id }

  # authorize_request
  let(:headers) { valid_headers(admin.id) }

  # Test suite for GET /admin/measures
  describe 'GET /admin/measures' do
    # make HTTP get request before each example
    before { get '/admin/measures', params: {}, headers: headers }

    it 'returns all adminf measures' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
