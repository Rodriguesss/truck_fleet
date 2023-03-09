FactoryBot.define do
  factory :delivery do
    association :product, factory: :product
    association :travel, factory: :travel
  end
end
