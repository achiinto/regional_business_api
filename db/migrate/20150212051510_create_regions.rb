class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :name
      t.float :sw_latitude
      t.float :sw_longitude
      t.float :ne_latitude
      t.float :ne_longitude
      t.integer :current_index, default: 0
      t.string :source_type, default: "yelp"

      t.timestamps null: false
    end
  end
end
