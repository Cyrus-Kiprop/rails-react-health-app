require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:measures).dependent(:destroy) }
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }

  it do
    should validate_length_of(:email).is_at_most(255)
  end

  subject { FactoryBot.create(:user)}

  it do
    should validate_uniqueness_of(:email).scoped_to(:id).ignoring_case_sensitivity
  end

  it { should validate_length_of(:password).is_at_least(6) }

end
