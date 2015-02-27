class AddIndexResourceIdforBusiness < ActiveRecord::Migration
  def change
    add_index :businesses, :resource_id, unique: true
  end
end
