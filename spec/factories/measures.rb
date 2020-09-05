FactoryBot.define do
  factory :measure do
    user_id { 1 }
    body_part_name { Faker::Lorem.word }
  end
end
