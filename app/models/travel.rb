class Travel < ApplicationRecord
  belongs_to :truck_driver
  belongs_to :origin_city, class_name: "City"
  belongs_to :destination_city, class_name: "City"
  belongs_to :product_type

  has_many :deliveries
end
