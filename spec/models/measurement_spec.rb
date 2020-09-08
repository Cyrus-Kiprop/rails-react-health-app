require 'rails_helper'

RSpec.describe Measurement, type: :model do
  it { should belong_to(:measure) }

  it { should validate_presence_of(:size) }
end
