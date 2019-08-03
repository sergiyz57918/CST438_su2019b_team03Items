FactoryBot.define do
  factory :item do
    description { Faker::Lorem.word }
    stockQty { Faker::Number.within(range: 1..100) }
    price { Faker::Number.positive }
  end
end