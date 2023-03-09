FactoryBot.define do
  factory :city do
    name { Faker::Address.city }
    association :uf, factory: :uf
  end
end
