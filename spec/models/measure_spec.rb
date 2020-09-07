require 'rails_helper'

RSpec.describe Measure, type: :model do
  # Association Test

  # Ensure todo list 1:1 rlship mapping
  it { should have_many(:measurements).dependent(:destroy) }
  it { should have_one(:body_part).dependent(:destroy) }

  let(:user) { FactoryBot.create(:user)}
  let(:user_id) { user.id}

  subject { FactoryBot.create(:measure, user_id: user_id)}

  it do
    should validate_uniqueness_of(:body_part_name).ignoring_case_sensitivity
  end
end
