class CreateTravels < ActiveRecord::Migration[7.0]
  def change
    create_table :travels do |t|
      t.date :destination_date
      t.date :date_of_origin
      t.date :expected_date
      t.references :origin_city, foreign_key: { to_table: :cities }
      t.references :destination_city, foreign_key: { to_table: :cities }
      t.references :truck_driver, foreign_key: { to_table: :truck_drivers }
      t.references :product_type, foreign_key: { to_table: :product_types }

      t.timestamps
    end
  end
end
