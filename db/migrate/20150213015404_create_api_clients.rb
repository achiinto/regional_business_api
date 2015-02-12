class CreateApiClients < ActiveRecord::Migration
  def change
    create_table :api_clients do |t|
      t.integer :daily_api_count
      t.string :consumer_key
      t.string :consumer_secret
      t.string :api_token
      t.string :api_token_secret

      t.timestamps null: false
    end
  end
end
