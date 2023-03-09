FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    price { Faker::Commerce.price(range: 10.0..1000.0, as_string: false) }
    weight { Faker::Measurement.weight }
    dimension { "#{Faker::Number.decimal(l_digits: 2)} x #{Faker::Number.decimal(l_digits: 2)} x #{Faker::Number.decimal(l_digits: 2)}" }
    description { Faker::Lorem.paragraph_by_chars(number: 256) }
  end
end
