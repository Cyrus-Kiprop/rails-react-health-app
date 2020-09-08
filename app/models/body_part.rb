class BodyPart < ApplicationRecord
  belongs_to :measure

  validates_presence_of(:name, :size)
end
