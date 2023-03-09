class AddUfIdToCities < ActiveRecord::Migration[7.0]
  def change
    add_reference :cities, :uf, null: false, foreign_key: true
  end
end
