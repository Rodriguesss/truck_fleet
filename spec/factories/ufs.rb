FactoryBot.define do
  factory :uf do
    name { Faker::Address.state_abbr }
  end
end
