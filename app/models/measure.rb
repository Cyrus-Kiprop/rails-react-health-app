class Measure < ApplicationRecord
  belongs_to :user

  has_one :body_part, dependent: :destroy


end
