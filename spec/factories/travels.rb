FactoryBot.define do
  factory :travel do
    destination_date { Faker::Date.between(from: 1.year.from_now, to: 2.years.from_now) }
    date_of_origin { Faker::Date.between(from: 1.year.ago, to: Date.today) }
    expected_date { Faker::Date.between(from: destination_date, to: 1.month.from_now(destination_date)) }
    association :origin_city, factory: :city
    association :destination_city, factory: :city
    association :truck_driver, factory: :truck_driver
    association :product_type, factory: :product_type
  end
end
