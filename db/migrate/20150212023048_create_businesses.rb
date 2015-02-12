class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :resource_id
      t.string :name
      t.string :image_url
      t.string :url
      t.string :phone
      t.integer :review_count
      t.text :categories, array: true, default: []
      t.string :display_address
      t.string :description
      t.boolean :is_closed
      t.float :search_lat
      t.float :search_long
      t.integer :distance_away

      t.timestamps null: false
    end
  end
end
