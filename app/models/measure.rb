class Measure < ApplicationRecord
  belongs_to :user

  has_one :body_part, dependent: :destroy

  validates_presence_of(:body_part_name)


end
