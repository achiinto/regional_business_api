class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :name
      t.float :sw_latitude
      t.float :sw_longitude
      t.float :ne_latitude
      t.float :ne_longitude
      t.float :current_sw_latitude
      t.float :current_sw_longitude
      t.float :current_ne_latitude
      t.float :current_ne_longitude
      t.integer :current_index
      t.string :source_type

      t.timestamps null: false
    end
  end
end
