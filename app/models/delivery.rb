class Delivery < ApplicationRecord
  belongs_to :travel
  belongs_to :product
end
