FactoryBot.define do
  factory :truck_driver do
    name { Faker::Address.state_abbr }
    age { rand(20..40) }
  end
end
