class City < ApplicationRecord
  belongs_to :uf

  has_many :origin_delivery, class_name: "Delivery", foreign_key: "origin_city_id"
  has_many :destination_delivery, class_name: "Delivery", foreign_key: "destination_city_id"
end
