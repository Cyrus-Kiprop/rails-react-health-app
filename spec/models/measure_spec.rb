require 'rails_helper'

RSpec.describe Measure, type: :model do
  # Association Test

  # Ensure todo list 1:1 rlship mapping
  it { should have_one(:body_part).dependent(:destroy)}
end
