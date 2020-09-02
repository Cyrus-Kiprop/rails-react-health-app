FactoryBot.define do
    factory :body_part do
      name { Faker::Name.word }
      size { Faker::Number.digits(10) }
      measure_id  nil
    end
  end