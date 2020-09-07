class Measure < ApplicationRecord
  belongs_to :user

  before_save { self.body_part_name = body_part_name ? body_part_name.split(' ').map(&:capitalize).join(' ') : body_part_name }

  has_one :body_part, dependent: :destroy
  has_many :measurements, dependent: :destroy

  validates_presence_of(:body_part_name)

  validates :body_part_name, uniqueness: true
end
