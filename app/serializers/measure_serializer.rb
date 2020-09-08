class MeasureSerializer < ActiveModel::Serializer
  attributes :id, :body_part_name, :user_id, :created_at, :updated_at

  has_many :measurements
end
